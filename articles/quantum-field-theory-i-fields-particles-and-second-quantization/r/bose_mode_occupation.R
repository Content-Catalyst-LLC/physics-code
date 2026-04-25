# Bose Occupation of Quantized Modes
#
# This workflow computes:
#
#   n_bar = 1 / (exp(beta hbar omega) - 1)

library(tidyverse)

article_dir <- "articles/quantum-field-theory-i-fields-particles-and-second-quantization"

output_path <- file.path(article_dir, "data/computed_bose_mode_occupation_r.csv")
summary_path <- file.path(article_dir, "data/computed_bose_mode_occupation_summary_r.csv")

boltzmann_constant_j_k <- 1.380649e-23
hbar_j_s <- 1.054571817e-34

mode_grid <- crossing(
  temperature_k = c(1, 10, 100, 300, 1000),
  angular_frequency_rad_s = c(1e10, 1e11, 1e12, 1e13, 1e14)
) %>%
  mutate(
    beta_j_inverse = 1 / (boltzmann_constant_j_k * temperature_k),
    mode_energy_j = hbar_j_s * angular_frequency_rad_s,
    dimensionless_energy = beta_j_inverse * mode_energy_j,
    mean_occupation = 1 / (exp(dimensionless_energy) - 1),
    zero_point_energy_j = 0.5 * mode_energy_j,
    thermal_energy_j = boltzmann_constant_j_k * temperature_k
  )

summary_table <- mode_grid %>%
  group_by(temperature_k) %>%
  summarise(
    min_mean_occupation = min(mean_occupation),
    median_mean_occupation = median(mean_occupation),
    max_mean_occupation = max(mean_occupation),
    .groups = "drop"
  )

write_csv(mode_grid, output_path)
write_csv(summary_table, summary_path)

print(mode_grid)
print(summary_table)

cat("\nSaved Bose occupation table to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
