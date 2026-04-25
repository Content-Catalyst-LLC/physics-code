# Landau Free Energy Across a Critical Point
#
# This workflow evaluates:
#
#   f(m) = a (T - Tc) m^2 + b m^4

library(tidyverse)

article_dir <- "articles/phase-transitions-critical-phenomena-and-the-renormalization-group"

input_path <- file.path(article_dir, "data/landau_cases.csv")
output_path <- file.path(article_dir, "data/computed_landau_free_energy_r.csv")
equilibrium_path <- file.path(article_dir, "data/computed_landau_equilibrium_r.csv")

cases <- read_csv(input_path, show_col_types = FALSE)

landau_grid <- cases %>%
  rowwise() %>%
  mutate(
    temperature = list(seq(temperature_min, temperature_max, length.out = n_temperatures)),
    order_parameter = list(seq(m_min, m_max, length.out = n_m))
  ) %>%
  unnest(temperature) %>%
  unnest(order_parameter) %>%
  ungroup() %>%
  mutate(
    reduced_temperature =
      (temperature - critical_temperature) / critical_temperature,
    free_energy =
      a_coefficient *
      (temperature - critical_temperature) *
      order_parameter^2 +
      b_coefficient *
      order_parameter^4
  )

equilibrium_table <- landau_grid %>%
  group_by(case_id, temperature) %>%
  slice_min(free_energy, n = 1, with_ties = FALSE) %>%
  ungroup() %>%
  mutate(
    absolute_order_parameter = abs(order_parameter),
    phase = if_else(
      absolute_order_parameter > 0.05,
      "ordered",
      "disordered"
    )
  )

write_csv(landau_grid, output_path)
write_csv(equilibrium_table, equilibrium_path)

print(landau_grid)
print(equilibrium_table)

cat("\nSaved Landau grid to:", output_path, "\n")
cat("Saved equilibrium table to:", equilibrium_path, "\n")
