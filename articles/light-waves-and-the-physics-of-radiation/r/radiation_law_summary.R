# Radiation Law Summary
#
# This workflow computes Wien peak wavelengths and Stefan-Boltzmann exitance
# for a set of sample temperatures.

library(tidyverse)

article_dir <- "articles/light-waves-and-the-physics-of-radiation"

input_path <- file.path(article_dir, "data/blackbody_temperatures.csv")
output_path <- file.path(article_dir, "data/computed_radiation_law_summary_r.csv")

stefan_boltzmann_constant <- 5.670374419e-8
wien_displacement_constant <- 2.897771955e-3

temperature_table <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    wien_peak_wavelength_m = wien_displacement_constant / temperature_k,
    wien_peak_wavelength_nm = wien_peak_wavelength_m * 1e9,
    stefan_boltzmann_exitance_w_m2 =
      stefan_boltzmann_constant * temperature_k^4
  )

write_csv(temperature_table, output_path)

print(temperature_table)
cat("\nSaved radiation law summary to:", output_path, "\n")
