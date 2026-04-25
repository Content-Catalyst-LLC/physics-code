# Experimental Energy Residuals
#
# This workflow compares measured spring-launch speeds with the ideal
# energy-conservation prediction:
#
#   1/2 k x^2 = 1/2 m v^2
#
# so:
#
#   v = x sqrt(k/m)

library(tidyverse)

article_dir <- "articles/energy-work-and-conservation-in-physical-systems"

input_path <- file.path(article_dir, "data/experimental_energy_measurements.csv")
output_path <- file.path(article_dir, "data/computed_experimental_energy_residuals_r.csv")

trials <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    predicted_speed_m_per_s =
      compression_m * sqrt(spring_constant_n_per_m / mass_kg),
    speed_residual_m_per_s =
      measured_speed_m_per_s - predicted_speed_m_per_s,
    predicted_kinetic_energy_j =
      0.5 * mass_kg * predicted_speed_m_per_s^2,
    measured_kinetic_energy_j =
      0.5 * mass_kg * measured_speed_m_per_s^2,
    energy_residual_j =
      measured_kinetic_energy_j - predicted_kinetic_energy_j,
    percent_energy_residual =
      100 * energy_residual_j / predicted_kinetic_energy_j
  )

summary_table <- trials %>%
  summarise(
    n_trials = n(),
    mean_speed_residual_m_per_s = mean(speed_residual_m_per_s),
    mean_abs_speed_residual_m_per_s = mean(abs(speed_residual_m_per_s)),
    mean_energy_residual_j = mean(energy_residual_j),
    mean_abs_percent_energy_residual = mean(abs(percent_energy_residual))
  )

write_csv(trials, output_path)

print(trials)
print(summary_table)
cat("\nSaved residual table to:", output_path, "\n")
