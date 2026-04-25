# Cosmology Parameter Summary
#
# This workflow reads parameter assumptions and creates derived summaries.

library(tidyverse)

article_dir <- "articles/cosmology-and-the-large-scale-structure-of-the-universe"

params <- read_csv(file.path(article_dir, "data/cosmology_parameters.csv"), show_col_types = FALSE)

get_param <- function(name) {
  params %>% filter(parameter == name) %>% pull(value)
}

omega_m <- get_param("Omega_m")
omega_b <- get_param("Omega_b")
omega_cdm <- get_param("Omega_cdm")
omega_lambda <- get_param("Omega_lambda")
h0 <- get_param("H0")

summary <- tibble(
  quantity = c(
    "matter_plus_lambda",
    "baryon_fraction_of_matter",
    "dark_matter_fraction_of_matter",
    "hubble_time_gyr_approx"
  ),
  value = c(
    omega_m + omega_lambda,
    omega_b / omega_m,
    omega_cdm / omega_m,
    9.778 / (h0 / 100)
  ),
  notes = c(
    "flatness check for late-time Lambda-CDM scaffold",
    "Omega_b divided by Omega_m",
    "Omega_cdm divided by Omega_m",
    "approximate Hubble time in Gyr"
  )
)

output_path <- file.path(article_dir, "data/computed_cosmology_parameter_summary_r.csv")
write_csv(summary, output_path)

print(summary)
cat("\nSaved cosmology parameter summary to:", output_path, "\n")
