args <- commandArgs(trailingOnly = TRUE)

script_arg <- commandArgs(trailingOnly = FALSE)
script_path <- sub("^--file=", "", script_arg[grep("^--file=", script_arg)][1])
repo_root <- normalizePath(file.path(dirname(script_path), ".."), winslash = "/", mustWork = TRUE)

source(file.path(repo_root, "R", "recaf_core.R"), encoding = "UTF-8")
source(file.path(repo_root, "R", "recaf_ggir.R"), encoding = "UTF-8")

usage <- function() {
  cat(
    paste0(
      "Uso:\n",
      "  Rscript scripts/ejecutar_recaf.R --input-dir DIR --output-dir DIR [opciones]\n\n",
      "Opciones:\n",
      "  --threshold NUM          Criterio semanal; predeterminado: 150\n",
      "  --overwrite              Sobrescribe resultados existentes\n",
      "  --archive-processed DIR  Mueve originales procesados correctamente\n",
      "  --help                   Muestra esta ayuda\n"
    )
  )
}

parse_args <- function(values) {
  result <- list(
    input_dir = NULL,
    output_dir = NULL,
    threshold = 150,
    overwrite = FALSE,
    archive_dir = NULL
  )
  i <- 1L
  while (i <= length(values)) {
    key <- values[[i]]
    if (key == "--help") {
      usage()
      quit(status = 0)
    } else if (key == "--overwrite") {
      result$overwrite <- TRUE
    } else if (key %in% c("--input-dir", "--output-dir", "--threshold", "--archive-processed")) {
      if (i == length(values)) stop(paste("Falta el valor de", key), call. = FALSE)
      i <- i + 1L
      value <- values[[i]]
      if (key == "--input-dir") result$input_dir <- value
      if (key == "--output-dir") result$output_dir <- value
      if (key == "--threshold") result$threshold <- as.numeric(value)
      if (key == "--archive-processed") result$archive_dir <- value
    } else {
      stop(paste("Opción no reconocida:", key), call. = FALSE)
    }
    i <- i + 1L
  }
  if (is.null(result$input_dir) || is.null(result$output_dir)) {
    usage()
    stop("Debe indicar --input-dir y --output-dir.", call. = FALSE)
  }
  if (!is.finite(result$threshold) || result$threshold <= 0) {
    stop("--threshold debe ser un número positivo.", call. = FALSE)
  }
  result
}

append_log <- function(log_file, row) {
  exists <- file.exists(log_file)
  utils::write.table(
    row,
    log_file,
    sep = ",",
    row.names = FALSE,
    col.names = !exists,
    append = exists,
    qmethod = "double",
    fileEncoding = "UTF-8"
  )
}

options <- parse_args(args)
input_dir <- normalizePath(options$input_dir, winslash = "/", mustWork = TRUE)
dir.create(options$output_dir, recursive = TRUE, showWarnings = FALSE)
output_dir <- normalizePath(options$output_dir, winslash = "/", mustWork = TRUE)
log_file <- file.path(output_dir, "recAF_registro_procesamiento.csv")

files <- list.files(input_dir, pattern = "\\.bin$", full.names = TRUE, ignore.case = TRUE)
if (length(files) == 0L) {
  stop("No se encontraron archivos .bin en la carpeta de entrada.", call. = FALSE)
}

failures <- 0L
for (input_file in files) {
  participant_id <- recaf_safe_id(input_file)
  participant_output <- file.path(output_dir, participant_id)
  started <- Sys.time()

  if (dir.exists(participant_output) && !options$overwrite) {
    message("Omitido (ya existe): ", participant_id)
    append_log(log_file, data.frame(
      timestamp = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"),
      participant_id = participant_id,
      status = "omitido",
      detail = "La carpeta de resultados ya existe; use --overwrite para recalcular.",
      elapsed_seconds = 0,
      stringsAsFactors = FALSE
    ))
    next
  }

  if (dir.exists(participant_output) && options$overwrite) {
    unlink(participant_output, recursive = TRUE, force = TRUE)
  }

  message("Procesando: ", basename(input_file))
  status <- "correcto"
  detail <- ""

  tryCatch({
    dir.create(participant_output, recursive = TRUE, showWarnings = FALSE)
    recaf_run_ggir(input_file, participant_output, participant_id)
    summary_file <- recaf_find_person_summary(participant_output)
    recaf_process_person_summary(
      summary_file,
      participant_id,
      participant_output,
      threshold_minutes = options$threshold
    )

    if (!is.null(options$archive_dir)) {
      dir.create(options$archive_dir, recursive = TRUE, showWarnings = FALSE)
      archive_target <- file.path(options$archive_dir, basename(input_file))
      if (file.exists(archive_target)) {
        stop("El archivo de destino ya existe en la carpeta de archivo; no se moverá el original.", call. = FALSE)
      }
      if (!file.rename(input_file, archive_target)) {
        stop("El procesamiento terminó, pero no se pudo archivar el archivo original.", call. = FALSE)
      }
    }
  }, error = function(error) {
    status <<- "error"
    detail <<- conditionMessage(error)
    failures <<- failures + 1L
    message("Error en ", participant_id, ": ", detail)
  })

  append_log(log_file, data.frame(
    timestamp = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"),
    participant_id = participant_id,
    status = status,
    detail = detail,
    elapsed_seconds = round(as.numeric(difftime(Sys.time(), started, units = "secs")), 2),
    stringsAsFactors = FALSE
  ))
}

if (failures > 0L) {
  message("Procesamiento finalizado con ", failures, " error(es).")
  quit(status = 1L)
}

message("Procesamiento finalizado correctamente.")
