required_r <- "4.4.0"
target_ggir <- "3.2-6"
target_ggirread <- "1.0.8"

if (getRversion() < required_r) {
  stop(paste("recAF requiere R", required_r, "o posterior."), call. = FALSE)
}

repos <- c(CRAN = "https://cloud.r-project.org")

if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes", repos = repos)
}

installed_ggir <- if (requireNamespace("GGIR", quietly = TRUE)) {
  as.character(utils::packageVersion("GGIR"))
} else {
  NA_character_
}

installed_ggirread <- if (requireNamespace("GGIRread", quietly = TRUE)) {
  as.character(utils::packageVersion("GGIRread"))
} else {
  NA_character_
}

if (is.na(installed_ggirread) || installed_ggirread != target_ggirread) {
  message("Instalando GGIRread ", target_ggirread, "...")
  remotes::install_version(
    "GGIRread",
    version = target_ggirread,
    repos = repos,
    upgrade = "never",
    dependencies = NA
  )
}

if (is.na(installed_ggir) || installed_ggir != target_ggir) {
  message("Instalando GGIR ", target_ggir, " y sus dependencias necesarias...")
  remotes::install_version(
    "GGIR",
    version = target_ggir,
    repos = repos,
    upgrade = "never",
    dependencies = NA
  )
}

actual_ggir <- as.character(utils::packageVersion("GGIR"))
actual_ggirread <- as.character(utils::packageVersion("GGIRread"))
if (actual_ggir != target_ggir) {
  stop(
    paste("Se esperaba GGIR", target_ggir, "pero se encontró", actual_ggir),
    call. = FALSE
  )
}

if (actual_ggirread != target_ggirread) {
  stop(
    paste("Se esperaba GGIRread", target_ggirread, "pero se encontró", actual_ggirread),
    call. = FALSE
  )
}

message(
  "Dependencias instaladas. GGIR: ", actual_ggir,
  "; GGIRread: ", actual_ggirread
)
