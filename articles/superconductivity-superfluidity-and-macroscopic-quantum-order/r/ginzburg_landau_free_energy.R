# Ginzburg-Landau Free Energy
#
# Evaluates:
#
#   f(|Psi|) = alpha(T) |Psi|^2 + beta/2 |Psi|^4
#
# with alpha(T) = alpha_0 (T - Tc).

library(tidyverse)

article_dir <- "articles/superconductivity-superfluidity-and-macroscopic-quantum-order"

cases <- read_csv(file.path(article_dir, "data/gl_parameter_cases.csv"), show_col_types = FALSE)

amplitudes <- tibble(
  psi_amplitude = seq(0, 4, length.out = 300)
)

free_energy_table <- cases %>%
  rowwise() %>%
  mutate(temperature_k = list(seq(temperature_min_k, temperature_max_k, length.out = 80))) %>%
  unnest(temperature_k) %>%
  ungroup() %>%
  crossing(amplitudes) %>%
  mutate(
    alpha = alpha_0 * (temperature_k - critical_temperature_k),
    free_energy_density = alpha * psi_amplitude^2 + 0.5 * beta * psi_amplitude^4
  )

minimum_table <- free_energy_table %>%
  group_by(case_id, temperature_k) %>%
  slice_min(free_energy_density, n = 1, with_ties = FALSE) %>%
  ungroup() %>%
  mutate(
    analytic_equilibrium_amplitude =
      if_else(alpha < 0, sqrt(-alpha / beta), 0)
  )

write_csv(
  free_energy_table,
  file.path(article_dir, "data/computed_gl_free_energy_r.csv")
)

write_csv(
  minimum_table,
  file.path(article_dir, "data/computed_gl_minimum_table_r.csv")
)

print(minimum_table)
