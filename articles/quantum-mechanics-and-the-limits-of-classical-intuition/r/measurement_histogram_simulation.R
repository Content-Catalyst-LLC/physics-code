# Measurement Histogram Simulation
#
# This workflow simulates position measurements for a particle-in-a-box
# probability density by sampling from a discretized distribution.

library(tidyverse)

output_path <- "articles/quantum-mechanics-and-the-limits-of-classical-intuition/data/computed_measurement_samples_r.csv"

set.seed(42)

box_length <- 1
n_grid <- 5000
x_grid <- seq(0, box_length, length.out = n_grid)
dx <- x_grid[2] - x_grid[1]

psi_sq <- function(n, x, box_length) {
  (2 / box_length) * sin(n * pi * x / box_length)^2
}

state_n <- 1
probability_density <- psi_sq(state_n, x_grid, box_length)
probability_weights <- probability_density / sum(probability_density)

sampled_positions <- sample(
  x = x_grid,
  size = 1000,
  replace = TRUE,
  prob = probability_weights
)

samples <- tibble(
  sample_id = seq_along(sampled_positions),
  state_n = state_n,
  position_fraction_of_L = sampled_positions / box_length
)

summary_table <- samples %>%
  summarise(
    n_samples = n(),
    mean_position_fraction = mean(position_fraction_of_L),
    sd_position_fraction = sd(position_fraction_of_L),
    min_position_fraction = min(position_fraction_of_L),
    max_position_fraction = max(position_fraction_of_L)
  )

write_csv(samples, output_path)

print(summary_table)
cat("\nSaved measurement samples to:", output_path, "\n")
