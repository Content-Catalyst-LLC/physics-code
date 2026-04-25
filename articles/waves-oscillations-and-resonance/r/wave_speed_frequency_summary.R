# Wave Speed, Frequency, and Wavelength Summary
#
# This workflow computes the missing wavelength values from:
#
#   v = f * lambda

library(tidyverse)

article_dir <- "articles/waves-oscillations-and-resonance"

input_path <- file.path(article_dir, "data/wave_medium_cases.csv")
output_path <- file.path(article_dir, "data/computed_wave_speed_frequency_summary_r.csv")

wave_table <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    computed_wavelength_m =
      wave_speed_m_per_s / frequency_hz,
    angular_frequency_rad_per_s =
      2 * pi * frequency_hz,
    wavenumber_rad_per_m =
      2 * pi / computed_wavelength_m
  )

write_csv(wave_table, output_path)

print(wave_table)
cat("\nSaved wave speed and frequency summary to:", output_path, "\n")
