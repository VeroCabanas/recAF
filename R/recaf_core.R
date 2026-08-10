recaf_required_columns <- function() {
  c(
    "dur_day_total_MOD_min_wei",
    "dur_day_MOD_unbt_min_wei",
    "dur_day_total_VIG_min_wei"
  )
}

recaf_validate_person_summary <- function(data) {
  if (!is.data.frame(data)) {
    stop("El resumen de GGIR debe ser un data.frame.", call. = FALSE)
  }
  if (nrow(data) != 1L) {
    stop(
      paste0("Se esperaba una fila por registro y se encontraron ", nrow(data), "."),
      call. = FALSE
    )
  }
  missing_columns <- setdiff(recaf_required_columns(), names(data))
  if (length(missing_columns) > 0L) {
    stop(
      paste("Faltan columnas requeridas:", paste(missing_columns, collapse = ", ")),
      call. = FALSE
    )
  }
  values <- unlist(data[1, recaf_required_columns()], use.names = TRUE)
  if (any(!is.finite(as.numeric(values)))) {
    stop("Las variables de AFMV contienen valores ausentes o no numéricos.", call. = FALSE)
  }
  invisible(TRUE)
}

recaf_calculate_weekly_mvpa <- function(data, threshold_minutes = 150) {
  recaf_validate_person_summary(data)
  if (length(threshold_minutes) != 1L || !is.finite(threshold_minutes) || threshold_minutes <= 0) {
    stop("El criterio semanal debe ser un número positivo.", call. = FALSE)
  }

  moderate_total <- as.numeric(data$dur_day_total_MOD_min_wei[[1]])
  moderate_unbouted <- as.numeric(data$dur_day_MOD_unbt_min_wei[[1]])
  vigorous_total <- as.numeric(data$dur_day_total_VIG_min_wei[[1]])

  moderate_bouted <- max(0, moderate_total - moderate_unbouted)
  moderate_weekly <- moderate_bouted * 7
  vigorous_weekly <- vigorous_total * 7
  mvpa_weekly <- moderate_weekly + vigorous_weekly
  percentage <- 100 * mvpa_weekly / threshold_minutes

  data.frame(
    moderate_bouted_weekly_min = moderate_weekly,
    vigorous_weekly_min = vigorous_weekly,
    mvpa_weekly_min = mvpa_weekly,
    threshold_weekly_min = threshold_minutes,
    percentage_of_threshold = percentage,
    meets_threshold = mvpa_weekly >= threshold_minutes,
    stringsAsFactors = FALSE
  )
}

recaf_safe_id <- function(path) {
  id <- tools::file_path_sans_ext(basename(path))
  id <- gsub("[^A-Za-z0-9._-]+", "_", id)
  id <- gsub("_+", "_", id)
  id <- gsub("^_+|_+$", "", id)
  if (!nzchar(id)) {
    stop("No se pudo obtener un identificador seguro del nombre de archivo.", call. = FALSE)
  }
  id
}

recaf_find_person_summary <- function(directory) {
  candidates <- list.files(
    directory,
    pattern = "^part5_personsummary_MM.*\\.csv$",
    recursive = TRUE,
    full.names = TRUE,
    ignore.case = TRUE
  )
  if (length(candidates) == 0L) {
    stop("No se encontró el resumen individual MM de la parte 5 de GGIR.", call. = FALSE)
  }
  if (length(candidates) > 1L) {
    stop(
      paste("Se encontró más de un resumen individual MM:", paste(basename(candidates), collapse = ", ")),
      call. = FALSE
    )
  }
  candidates[[1]]
}

recaf_plot_summary <- function(summary, participant_id, output_file) {
  required <- c("mvpa_weekly_min", "threshold_weekly_min", "percentage_of_threshold", "meets_threshold")
  missing_columns <- setdiff(required, names(summary))
  if (length(missing_columns) > 0L) {
    stop("El resumen calculado no contiene todas las variables requeridas.", call. = FALSE)
  }

  minutes <- as.numeric(summary$mvpa_weekly_min[[1]])
  threshold <- as.numeric(summary$threshold_weekly_min[[1]])
  percentage <- as.numeric(summary$percentage_of_threshold[[1]])
  meets <- isTRUE(summary$meets_threshold[[1]])
  upper <- max(400, ceiling(max(minutes, threshold) / 50) * 50)
  bar_height <- min(minutes, upper)
  bar_color <- if (meets) "#2E8B57" else "#D73027"

  grDevices::png(output_file, width = 1800, height = 1350, res = 200, bg = "white")
  on.exit(grDevices::dev.off(), add = TRUE)
  graphics::par(mar = c(6, 7, 7, 2), family = "sans")
  graphics::plot.new()
  graphics::plot.window(xlim = c(0, 1), ylim = c(0, upper), xaxs = "i", yaxs = "i")
  graphics::rect(0, 0, 1, threshold, col = "#FDE2E2", border = NA)
  graphics::rect(0, threshold, 1, min(2 * threshold, upper), col = "#D8F3DC", border = NA)
  if (upper > 2 * threshold) {
    graphics::rect(0, 2 * threshold, 1, upper, col = "#FFF7AE", border = NA)
  }
  graphics::abline(h = threshold, lty = 2, lwd = 2, col = "#4D4D4D")
  graphics::rect(0.35, 0, 0.65, bar_height, col = bar_color, border = NA)
  label_y <- min(max(bar_height + upper * 0.04, upper * 0.07), upper * 0.94)
  graphics::text(
    0.5,
    label_y,
    labels = sprintf("%.2f min (%.2f%%)", minutes, percentage),
    cex = 1.4,
    font = 2
  )
  graphics::axis(2, las = 1, cex.axis = 1.15)
  graphics::box(bty = "l", col = "#999999")
  graphics::mtext("Actividad física moderada-vigorosa", side = 1, line = 3.5, cex = 1.25)
  graphics::mtext("Tiempo acumulado semanal (min)", side = 2, line = 4.2, cex = 1.25)
  graphics::title(
    main = paste0("Criterio semanal de AFMV\n", participant_id),
    cex.main = 1.55
  )
  graphics::mtext(
    paste0("Criterio configurado: ", format(threshold, trim = TRUE), " min/semana"),
    side = 3,
    line = 0.7,
    cex = 1.05
  )
  invisible(output_file)
}

recaf_process_person_summary <- function(summary_file, participant_id, output_directory, threshold_minutes = 150) {
  data <- utils::read.csv(summary_file, check.names = FALSE)
  result <- recaf_calculate_weekly_mvpa(data, threshold_minutes = threshold_minutes)
  result$participant_id <- participant_id
  result <- result[c("participant_id", setdiff(names(result), "participant_id"))]

  dir.create(output_directory, recursive = TRUE, showWarnings = FALSE)
  csv_file <- file.path(output_directory, paste0(participant_id, "_resumen_recAF.csv"))
  png_file <- file.path(output_directory, paste0(participant_id, "_cumplimiento_AFMV.png"))
  utils::write.csv(result, csv_file, row.names = FALSE, fileEncoding = "UTF-8")
  recaf_plot_summary(result, participant_id, png_file)

  list(summary = result, csv = csv_file, figure = png_file)
}
