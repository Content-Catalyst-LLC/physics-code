# Blackbody Spectra and Double-Slit Interference
#
# This workflow computes Planck spectral radiance and a simple double-slit
# intensity scan, then writes reusable output tables.

library(tidyverse)

article_dir <- "articles/light-waves-and-the-physics-of-radiation"

blackbody_output <- file.path(article_dir, "data/computed_blackbody_r.csv")
interference_output <- file.path(article_dir, "data/computed_interference_r.csv")
peak_output <- file.path(article_dir, "data/computed_blackbody_peaks_r.csv")

planck_constant <- 6.62607015e-34
speed_of_light <- 299792458
boltzmann_constant <- 1.380649e-23

planck_lambda <- function(wavelength_m, temperature_k) {
  numerator <- 2 * planck_constant * speed_of_light^2
  denominator <- wavelength_m^5 *
    (exp(planck_constant * speed_of_light /
           (wavelength_m * boltzmann_constant * temperature_k)) - 1)

  numerator / denominator
}

wavelength_grid_m <- seq(100e-9, 3000e-9, length.out = 800)

blackbody_table <- tibble(
  wavelength_m = wavelength_grid_m,
  T3000 = planck_lambda(wavelength_grid_m, 3000),
  T4500 = planck_lambda(wavelength_grid_m, 4500),
  T6000 = planck_lambda(wavelength_grid_m, 6000)
) %>%
  pivot_longer(
    cols = starts_with("T"),
    names_to = "temperature_label",
    values_to = "spectral_radiance"
  ) %>%
  mutate(
    wavelength_nm = wavelength_m * 1e9,
    temperature_k = as.numeric(gsub("T", "", temperature_label))
  )

peak_table <- blackbody_table %>%
  group_by(temperature_k) %>%
  slice_max(spectral_radiance, n = 1, with_ties = FALSE) %>%
  ungroup() %>%
  select(temperature_k, peak_wavelength_nm = wavelength_nm, peak_radiance = spectral_radiance)

screen_position_m <- seq(-0.01, 0.01, length.out = 1000)
wavelength_m <- 550e-9
slit_separation_m <- 0.2e-3
screen_distance_m <- 1.5

interference_table <- tibble(
  screen_position_m = screen_position_m
) %>%
  mutate(
    theta_rad = atan(screen_position_m / screen_distance_m),
    phase_argument = pi * slit_separation_m * sin(theta_rad) / wavelength_m,
    relative_intensity = cos(phase_argument)^2,
    screen_position_mm = screen_position_m * 1000
  )

write_csv(blackbody_table, blackbody_output)
write_csv(interference_table, interference_output)
write_csv(peak_table, peak_output)

print(head(blackbody_table, 12))
print(peak_table)
print(head(interference_table, 12))
cat("\nSaved blackbody table to:", blackbody_output, "\n")
cat("Saved interference table to:", interference_output, "\n")
cat("Saved peak table to:", peak_output, "\n")
