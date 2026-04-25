# Debye Sphere Summary
#
# This workflow computes:
#
#   N_D = (4 pi / 3) n_e lambda_D^3

library(tidyverse)

article_dir <- "articles/plasma-physics-and-the-fourth-state-of-matter"

input_path <- file.path(article_dir, "data/plasma_regime_cases.csv")
output_path <- file.path(article_dir, "data/computed_debye_sphere_summary_r.csv")

epsilon_0_f_m <- 8.8541878128e-12
elementary_charge_c <- 1.602176634e-19

cases <- read_csv(input_path, show_col_types = FALSE)

summary <- cases %>%
  mutate(
    electron_temperature_j = electron_temperature_ev * elementary_charge_c,
    debye_length_m =
      sqrt(
        epsilon_0_f_m *
          electron_temperature_j /
          (electron_density_m3 * elementary_charge_c^2)
      ),
    debye_sphere_particles =
      (4 * pi / 3) * electron_density_m3 * debye_length_m^3,
    system_to_debye_ratio = system_size_m / debye_length_m,
    plasma_size_criterion = system_to_debye_ratio > 100,
    collective_shielding_criterion = debye_sphere_particles > 1
  ) %>%
  select(
    case_id,
    electron_density_m3,
    electron_temperature_ev,
    system_size_m,
    debye_length_m,
    debye_sphere_particles,
    system_to_debye_ratio,
    plasma_size_criterion,
    collective_shielding_criterion
  )

write_csv(summary, output_path)

print(summary)
cat("\nSaved Debye sphere summary to:", output_path, "\n")
