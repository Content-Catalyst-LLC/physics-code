# Lorentz Factors and Energy Scaling
#
# This workflow computes the Lorentz factor:
#
#   gamma = 1 / sqrt(1 - beta^2)
#
# and compares relativistic kinetic-energy scaling:
#
#   K_rel / (mc^2) = gamma - 1
#
# with the low-speed Newtonian approximation:
#
#   K_newtonian / (mc^2) = beta^2 / 2

library(tidyverse)

output_path <- "articles/relativity-and-the-reconstruction-of-space-and-time/data/computed_lorentz_factor_energy_scaling_r.csv"

relativity_table <- tibble(
  beta = seq(0, 0.995, length.out = 800)
) %>%
  mutate(
    gamma = 1 / sqrt(1 - beta^2),
    classical_time_factor = 1,
    relativistic_kinetic_energy_scaled = gamma - 1,
    newtonian_kinetic_energy_scaled = 0.5 * beta^2,
    kinetic_energy_difference =
      relativistic_kinetic_energy_scaled - newtonian_kinetic_energy_scaled,
    kinetic_energy_ratio =
      relativistic_kinetic_energy_scaled / newtonian_kinetic_energy_scaled
  )

summary_table <- relativity_table %>%
  filter(beta > 0) %>%
  summarise(
    maximum_beta = max(beta),
    maximum_gamma = max(gamma),
    median_energy_ratio = median(kinetic_energy_ratio),
    maximum_energy_difference = max(kinetic_energy_difference)
  )

write_csv(relativity_table, output_path)

print(head(relativity_table, 12))
print(summary_table)
cat("\nSaved relativity table to:", output_path, "\n")
