# Spring-Mass Energy Accounting
#
# This workflow computes kinetic energy, spring potential energy, and total
# mechanical energy for an ideal conservative spring-mass oscillator.

library(tidyverse)

article_dir <- "articles/energy-work-and-conservation-in-physical-systems"

energy_output <- file.path(article_dir, "data/computed_spring_mass_energy_accounting_r.csv")
summary_output <- file.path(article_dir, "data/computed_spring_mass_energy_summary_r.csv")

mass_kg <- 0.50
spring_constant_n_per_m <- 20.0
amplitude_m <- 0.10

angular_frequency_rad_per_s <- sqrt(spring_constant_n_per_m / mass_kg)

energy_table <- tibble(
  time_s = seq(0, 10, by = 0.01)
) %>%
  mutate(
    displacement_m =
      amplitude_m * cos(angular_frequency_rad_per_s * time_s),
    velocity_m_per_s =
      -amplitude_m * angular_frequency_rad_per_s *
      sin(angular_frequency_rad_per_s * time_s),
    kinetic_energy_j =
      0.5 * mass_kg * velocity_m_per_s^2,
    spring_potential_energy_j =
      0.5 * spring_constant_n_per_m * displacement_m^2,
    total_mechanical_energy_j =
      kinetic_energy_j + spring_potential_energy_j
  )

energy_summary <- energy_table %>%
  summarise(
    mean_total_energy_j = mean(total_mechanical_energy_j),
    min_total_energy_j = min(total_mechanical_energy_j),
    max_total_energy_j = max(total_mechanical_energy_j),
    total_energy_range_j =
      max_total_energy_j - min_total_energy_j,
    relative_energy_range =
      total_energy_range_j / mean_total_energy_j
  )

write_csv(energy_table, energy_output)
write_csv(energy_summary, summary_output)

print(head(energy_table, 12))
print(energy_summary)

cat("\nSaved energy table to:", energy_output, "\n")
cat("Saved energy summary to:", summary_output, "\n")
