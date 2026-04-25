# Pendulum Energy and Phase-Space Summary
#
# This workflow computes the simple pendulum Hamiltonian:
#
#   H(theta, p_theta) =
#     p_theta^2 / (2 m l^2) + m g l (1 - cos(theta))

library(tidyverse)

article_dir <- "articles/lagrangian-and-hamiltonian-mechanics"

output_path <- file.path(article_dir, "data/computed_pendulum_phase_space_grid_r.csv")
summary_path <- file.path(article_dir, "data/computed_pendulum_phase_space_summary_r.csv")

mass_kg <- 1.0
length_m <- 1.0
gravity_m_per_s2 <- 9.80665

phase_space_grid <- tidyr::crossing(
  theta_rad = seq(-pi, pi, length.out = 121),
  p_theta_kg_m2_per_s = seq(-6, 6, length.out = 121)
) %>%
  mutate(
    kinetic_energy_j =
      p_theta_kg_m2_per_s^2 /
        (2 * mass_kg * length_m^2),
    potential_energy_j =
      mass_kg * gravity_m_per_s2 * length_m *
        (1 - cos(theta_rad)),
    hamiltonian_j =
      kinetic_energy_j + potential_energy_j,
    separatrix_energy_j =
      2 * mass_kg * gravity_m_per_s2 * length_m,
    energy_region = case_when(
      hamiltonian_j < separatrix_energy_j ~ "oscillatory",
      TRUE ~ "rotational_or_separatrix_region"
    )
  )

phase_summary <- phase_space_grid %>%
  group_by(energy_region) %>%
  summarise(
    count = n(),
    min_energy_j = min(hamiltonian_j),
    mean_energy_j = mean(hamiltonian_j),
    max_energy_j = max(hamiltonian_j),
    .groups = "drop"
  )

write_csv(phase_space_grid, output_path)
write_csv(phase_summary, summary_path)

print(head(phase_space_grid, 12))
print(phase_summary)

cat("\nSaved phase-space grid to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
