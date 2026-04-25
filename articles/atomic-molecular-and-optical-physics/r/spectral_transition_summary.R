# Spectral Transition Summary
#
# This workflow summarizes the hydrogen spectral line table produced by Python,
# if available, and otherwise creates a compact illustrative table.

library(tidyverse)

article_dir <- "articles/atomic-molecular-and-optical-physics"

input_path <- file.path(article_dir, "data/computed_hydrogen_spectral_lines.csv")
output_path <- file.path(article_dir, "data/computed_spectral_transition_summary_r.csv")

if (file.exists(input_path)) {
  transitions <- read_csv(input_path, show_col_types = FALSE)
} else {
  transitions <- tibble(
    series = c("Lyman", "Balmer", "Paschen"),
    n_lower = c(1, 2, 3),
    n_upper = c(2, 3, 4),
    wavelength_nm = c(121.6, 656.3, 1875.0),
    photon_energy_ev = c(10.2, 1.89, 0.66),
    spectral_region = c("ultraviolet", "visible", "near_infrared")
  )
}

summary_table <- transitions %>%
  group_by(series, spectral_region) %>%
  summarise(
    line_count = n(),
    min_wavelength_nm = min(wavelength_nm),
    max_wavelength_nm = max(wavelength_nm),
    mean_photon_energy_ev = mean(photon_energy_ev),
    .groups = "drop"
  )

write_csv(summary_table, output_path)

print(summary_table)
cat("\nSaved spectral transition summary to:", output_path, "\n")
