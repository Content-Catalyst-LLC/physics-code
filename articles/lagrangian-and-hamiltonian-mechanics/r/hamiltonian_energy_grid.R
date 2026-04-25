# Hamiltonian Energy Grid
#
# This workflow evaluates several Hamiltonians on a shared coordinate grid.

library(tidyverse)

article_dir <- "articles/lagrangian-and-hamiltonian-mechanics"

output_path <- file.path(article_dir, "data/computed_hamiltonian_energy_grid_r.csv")

mass_kg <- 1.0
spring_constant_n_per_m <- 10.0
gravity_m_per_s2 <- 9.80665
length_m <- 1.0

grid <- tidyr::crossing(
  coordinate = seq(-2, 2, length.out = 101),
  momentum = seq(-4, 4, length.out = 101)
) %>%
  mutate(
    harmonic_oscillator_hamiltonian_j =
      momentum^2 / (2 * mass_kg) +
        0.5 * spring_constant_n_per_m * coordinate^2,
    pendulum_hamiltonian_j =
      momentum^2 / (2 * mass_kg * length_m^2) +
        mass_kg * gravity_m_per_s2 * length_m *
        (1 - cos(coordinate))
  )

write_csv(grid, output_path)

print(head(grid, 12))
cat("\nSaved Hamiltonian energy grid to:", output_path, "\n")
