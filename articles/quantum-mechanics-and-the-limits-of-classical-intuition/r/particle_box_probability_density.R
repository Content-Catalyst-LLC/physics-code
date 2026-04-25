# Particle-in-a-Box Probability Densities
#
# This workflow computes probability densities for the first three
# stationary states of a one-dimensional infinite square well:
#
#   psi_n(x) = sqrt(2/L) * sin(n*pi*x/L)
#
# It also checks numerical normalization.

library(tidyverse)

output_path <- "articles/quantum-mechanics-and-the-limits-of-classical-intuition/data/computed_probability_density_r.csv"

box_length <- 1
n_grid <- 2000
x_grid <- seq(0, box_length, length.out = n_grid)
dx <- x_grid[2] - x_grid[1]

particle_in_box_psi <- function(n, x, box_length) {
  sqrt(2 / box_length) * sin(n * pi * x / box_length)
}

probability_data <- tibble(
  x = x_grid,
  n_1 = particle_in_box_psi(1, x_grid, box_length)^2,
  n_2 = particle_in_box_psi(2, x_grid, box_length)^2,
  n_3 = particle_in_box_psi(3, x_grid, box_length)^2
) %>%
  pivot_longer(
    cols = starts_with("n_"),
    names_to = "state",
    values_to = "probability_density"
  )

normalization_check <- probability_data %>%
  group_by(state) %>%
  summarise(
    approximate_integral = sum(probability_density) * dx,
    maximum_probability_density = max(probability_density),
    .groups = "drop"
  )

write_csv(probability_data, output_path)

print(head(probability_data, 12))
print(normalization_check)
cat("\nSaved probability density table to:", output_path, "\n")
