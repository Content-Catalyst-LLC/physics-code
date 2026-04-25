# Two-State Macrostate Distributions and Fluctuation Scaling
#
# This workflow computes exact macrostate probabilities for independent
# two-state constituents and summarizes how relative fluctuations shrink
# with system size.

library(tidyverse)

article_dir <- "articles/statistical-physics-and-the-emergence-of-macroscopic-order"

distribution_output <- file.path(article_dir, "data/computed_two_state_distribution_r.csv")
summary_output <- file.path(article_dir, "data/computed_fluctuation_scaling_r.csv")

boltzmann_constant_j_per_k <- 1.380649e-23
temperature_k <- 300
excitation_energy_j <- 2e-21
beta_per_joule <- 1 / (boltzmann_constant_j_per_k * temperature_k)

macrostate_distribution <- function(number_of_particles) {
  excited_count <- 0:number_of_particles

  log_weights <- lchoose(number_of_particles, excited_count) -
    beta_per_joule * excited_count * excitation_energy_j

  normalized_weights <- exp(log_weights - max(log_weights))
  probability <- normalized_weights / sum(normalized_weights)

  tibble(
    N = number_of_particles,
    n_excited = excited_count,
    probability = probability
  )
}

distribution_table <- map_dfr(
  c(10, 50, 200, 1000),
  macrostate_distribution
)

summary_table <- distribution_table %>%
  group_by(N) %>%
  summarise(
    mean_excited = sum(n_excited * probability),
    variance_excited = sum((n_excited - mean_excited)^2 * probability),
    sd_excited = sqrt(variance_excited),
    relative_fluctuation = sd_excited / mean_excited,
    most_probable_n = n_excited[which.max(probability)],
    max_probability = max(probability),
    .groups = "drop"
  )

write_csv(distribution_table, distribution_output)
write_csv(summary_table, summary_output)

print(head(distribution_table, 12))
print(summary_table)
cat("\nSaved distribution table to:", distribution_output, "\n")
cat("Saved summary table to:", summary_output, "\n")
