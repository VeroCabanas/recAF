script_arg <- commandArgs(trailingOnly = FALSE)
script_path <- sub("^--file=", "", script_arg[grep("^--file=", script_arg)][1])
repo_root <- normalizePath(file.path(dirname(script_path), ".."), winslash = "/", mustWork = TRUE)

source(file.path(repo_root, "R", "recaf_core.R"), encoding = "UTF-8")

synthetic <- data.frame(
  dur_day_total_MOD_min_wei = 25,
  dur_day_MOD_unbt_min_wei = 10,
  dur_day_total_VIG_min_wei = 10
)

result <- recaf_calculate_weekly_mvpa(synthetic, threshold_minutes = 150)
stopifnot(isTRUE(all.equal(result$moderate_bouted_weekly_min, 105)))
stopifnot(isTRUE(all.equal(result$vigorous_weekly_min, 70)))
stopifnot(isTRUE(all.equal(result$mvpa_weekly_min, 175)))
stopifnot(isTRUE(all.equal(result$percentage_of_threshold, 175 / 150 * 100)))
stopifnot(isTRUE(result$meets_threshold))

zero_moderate <- synthetic
zero_moderate$dur_day_MOD_unbt_min_wei <- 30
result_zero <- recaf_calculate_weekly_mvpa(zero_moderate, threshold_minutes = 150)
stopifnot(result_zero$moderate_bouted_weekly_min == 0)

invalid <- synthetic[, -1]
error_detected <- inherits(try(recaf_calculate_weekly_mvpa(invalid), silent = TRUE), "try-error")
stopifnot(error_detected)

temporary_output <- tempfile("recaf_test_")
dir.create(temporary_output)
processed <- recaf_process_person_summary(
  file.path(repo_root, "examples", "person_summary_sintetico.csv"),
  "EJEMPLO_PRUEBA",
  temporary_output,
  threshold_minutes = 150
)
stopifnot(file.exists(processed$csv))
stopifnot(file.exists(processed$figure))
unlink(temporary_output, recursive = TRUE, force = TRUE)

cat("Todas las pruebas de recAF han finalizado correctamente.\n")

