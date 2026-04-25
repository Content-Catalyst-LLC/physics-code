# Critical Scaling Tables
#
# This workflow computes simple critical scaling forms:
#
#   m ~ (-t)^beta
#   chi ~ |t|^-gamma
#   xi ~ |t|^-nu

library(tidyverse)

article_dir <- "articles/phase-transitions-critical-phenomena-and-the-renormalization-group"

input_path <- file.path(article_dir, "data/critical_exponent_cases.csv")
output_path <- file.path(article_dir, "data/computed_critical_scaling_tables_r.csv")

exponents <- read_csv(input_path, show_col_types = FALSE)

reduced_temperatures <- c(-0.5, -0.25, -0.1, -0.05, -0.02, 0.02, 0.05, 0.1, 0.25, 0.5)

scaling_table <- crossing(
  exponents,
  reduced_temperature = reduced_temperatures
) %>%
  mutate(
    order_parameter_scale = if_else(
      reduced_temperature < 0,
      abs(reduced_temperature)^beta_exponent,
      NA_real_
    ),
    susceptibility_scale = abs(reduced_temperature)^(-gamma_exponent),
    correlation_length_scale = abs(reduced_temperature)^(-nu_exponent)
  )

write_csv(scaling_table, output_path)

print(scaling_table)
cat("\nSaved critical scaling table to:", output_path, "\n")
