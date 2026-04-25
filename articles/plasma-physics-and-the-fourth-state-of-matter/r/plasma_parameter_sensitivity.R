# Plasma Parameter Sensitivity
#
# This workflow computes foundational plasma quantities:
#
#   lambda_D = sqrt(epsilon_0 k_B T_e / (n_e e^2))
#   omega_pe = sqrt(n_e e^2 / (epsilon_0 m_e))
#   Omega_ce = e B / m_e
#   beta = 2 mu_0 p / B^2

library(tidyverse)

article_dir <- "articles/plasma-physics-and-the-fourth-state-of-matter"

output_path <- file.path(article_dir, "data/computed_plasma_parameter_sensitivity_r.csv")
summary_path <- file.path(article_dir, "data/computed_plasma_parameter_summary_r.csv")

epsilon_0_f_m <- 8.8541878128e-12
mu_0_h_m <- 4 * pi * 1e-7
elementary_charge_c <- 1.602176634e-19
electron_mass_kg <- 9.1093837015e-31

parameter_grid <- crossing(
  electron_density_m3 = c(1e14, 1e16, 1e18, 1e20),
  electron_temperature_ev = c(1, 10, 100),
  magnetic_field_t = c(0.01, 0.1, 1.0, 5.0)
) %>%
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
    electron_plasma_angular_frequency_rad_s =
      sqrt(
        electron_density_m3 *
          elementary_charge_c^2 /
          (epsilon_0_f_m * electron_mass_kg)
      ),
    electron_plasma_frequency_hz =
      electron_plasma_angular_frequency_rad_s / (2 * pi),
    electron_cyclotron_angular_frequency_rad_s =
      elementary_charge_c * magnetic_field_t / electron_mass_kg,
    electron_cyclotron_frequency_hz =
      electron_cyclotron_angular_frequency_rad_s / (2 * pi),
    plasma_pressure_pa =
      electron_density_m3 * electron_temperature_j,
    magnetic_pressure_pa =
      magnetic_field_t^2 / (2 * mu_0_h_m),
    plasma_beta =
      plasma_pressure_pa / magnetic_pressure_pa
  )

summary_table <- parameter_grid %>%
  group_by(electron_density_m3, electron_temperature_ev) %>%
  summarise(
    debye_length_m = first(debye_length_m),
    debye_sphere_particles = first(debye_sphere_particles),
    plasma_frequency_hz = first(electron_plasma_frequency_hz),
    min_plasma_beta = min(plasma_beta),
    max_plasma_beta = max(plasma_beta),
    .groups = "drop"
  )

write_csv(parameter_grid, output_path)
write_csv(summary_table, summary_path)

print(parameter_grid)
print(summary_table)

cat("\nSaved parameter grid to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
