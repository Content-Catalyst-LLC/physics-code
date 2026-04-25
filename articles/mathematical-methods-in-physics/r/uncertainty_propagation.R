# Uncertainty Propagation for Kinetic Energy
#
# This workflow estimates uncertainty in:
#
#   K = 1/2 m v^2

library(tidyverse)

article_dir <- "articles/mathematical-methods-in-physics"

input_path <- file.path(article_dir, "data/measurement_uncertainty_cases.csv")
output_path <- file.path(article_dir, "data/computed_uncertainty_propagation_r.csv")

measurement_table <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    kinetic_energy_j =
      0.5 * mass_kg * velocity_m_per_s^2,
    dK_dm =
      0.5 * velocity_m_per_s^2,
    dK_dv =
      mass_kg * velocity_m_per_s,
    kinetic_energy_uncertainty_j =
      sqrt(
        (dK_dm * mass_uncertainty_kg)^2 +
          (dK_dv * velocity_uncertainty_m_per_s)^2
      ),
    relative_uncertainty =
      kinetic_energy_uncertainty_j / kinetic_energy_j
  )

write_csv(measurement_table, output_path)

print(measurement_table)
cat("\nSaved uncertainty propagation table to:", output_path, "\n")
