script_arg <- commandArgs(trailingOnly = FALSE)
script_path <- sub("^--file=", "", script_arg[grep("^--file=", script_arg)][1])
example_dir <- normalizePath(dirname(script_path), winslash = "/", mustWork = TRUE)
repo_root <- normalizePath(file.path(example_dir, ".."), winslash = "/", mustWork = TRUE)

source(file.path(repo_root, "R", "recaf_core.R"), encoding = "UTF-8")

output_dir <- file.path(example_dir, "output_sintetico")
result <- recaf_process_person_summary(
  file.path(example_dir, "person_summary_sintetico.csv"),
  participant_id = "EJEMPLO_SINTETICO",
  output_directory = output_dir,
  threshold_minutes = 150
)

print(result$summary)
message("Ejemplo generado en: ", output_dir)

