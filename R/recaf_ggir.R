recaf_run_ggir <- function(input_file, output_directory, participant_id) {
  if (!requireNamespace("GGIR", quietly = TRUE)) {
    stop("GGIR no está instalado. Ejecute scripts/instalar_dependencias.R.", call. = FALSE)
  }
  if (!file.exists(input_file)) {
    stop(paste("No existe el archivo de entrada:", input_file), call. = FALSE)
  }

  dir.create(output_directory, recursive = TRUE, showWarnings = FALSE)

  suppressWarnings(
    suppressMessages(
      GGIR::GGIR(
        mode = 1:5,
        datadir = normalizePath(input_file, winslash = "/", mustWork = TRUE),
        outputdir = normalizePath(output_directory, winslash = "/", mustWork = TRUE),
        studyname = participant_id,
        idloc = 6,
        HASPT.algo = c("NotWorn", "HDCZA"),
        part5_agg2_60seconds = TRUE,
        mvpathreshold = 100,
        threshold.lig = 35,
        threshold.mod = 100,
        threshold.vig = 400,
        boutdur.mvpa = 3,
        boutdur.lig = 3,
        boutdur.in = 60,
        boutcriter.mvpa = 1,
        timewindow = "MM",
        save_ms5rawlevels = FALSE,
        includedaycrit = 22,
        includedaycrit.part5 = 10,
        includenightcrit = 22,
        do.report = c(2, 4, 5),
        visualreport = FALSE,
        old_visualreport = FALSE
      )
    )
  )

  invisible(output_directory)
}

