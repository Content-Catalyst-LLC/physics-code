# Bose and Fermi Occupation Statistics
#
# This workflow compares ideal occupation functions:
#
#   Fermi-Dirac:    f(E) = 1 / (exp((E - mu)/(k_B T)) + 1)
#   Bose-Einstein: n(E) = 1 / (exp((E - mu)/(k_B T)) - 1)

library(tidyverse)

article_dir <- "articles/many-body-physics-and-emergent-collective-behavior"

input_path <- file.path(article_dir, "data/occupation_cases.csv")
output_path <- file.path(article_dir, "data/computed_occupation_statistics_r.csv")
summary_path <- file.path(article_dir, "data/computed_occupation_statistics_summary_r.csv")

boltzmann_constant_ev_k <- 8.617333262e-5

cases <- read_csv(input_path, show_col_types = FALSE)

occupation_table <- cases %>%
  rowwise() %>%
  mutate(energy_ev = list(seq(energy_min_ev, energy_max_ev, length.out = n_points))) %>%
  unnest(energy_ev) %>%
  ungroup() %>%
  mutate(
    dimensionless_energy =
      (energy_ev - chemical_potential_ev) /
      (boltzmann_constant_ev_k * temperature_k),
    fermi_occupation =
      1 / (exp(dimensionless_energy) + 1),
    bose_occupation =
      if_else(
        energy_ev > chemical_potential_ev,
        1 / (exp(dimensionless_energy) - 1),
        NA_real_
      )
  )

summary_table <- occupation_table %>%
  group_by(case_id, temperature_k) %>%
  summarise(
    fermi_min = min(fermi_occupation, na.rm = TRUE),
    fermi_max = max(fermi_occupation, na.rm = TRUE),
    bose_max_finite = max(bose_occupation, na.rm = TRUE),
    .groups = "drop"
  )

write_csv(occupation_table, output_path)
write_csv(summary_table, summary_path)

print(occupation_table)
print(summary_table)

cat("\nSaved occupation table to:", output_path, "\n")
cat("Saved occupation summary to:", summary_path, "\n")
