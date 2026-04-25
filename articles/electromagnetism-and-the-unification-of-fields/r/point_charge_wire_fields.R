# Point-Charge Field, Electric Potential, and Wire Magnetic Field
#
# This workflow computes:
#
#   E(r) = q / (4*pi*epsilon0*r^2)
#   V(r) = q / (4*pi*epsilon0*r)
#   B(r) = mu0*I / (2*pi*r)
#
# It also compares measured field values against theoretical values.

library(tidyverse)

article_dir <- "articles/electromagnetism-and-the-unification-of-fields"

measurement_path <- file.path(article_dir, "data/point_charge_measurements.csv")
field_output <- file.path(article_dir, "data/computed_point_charge_wire_fields_r.csv")
comparison_output <- file.path(article_dir, "data/computed_field_measurement_comparison_r.csv")

epsilon0 <- 8.8541878188e-12
mu0 <- 1.25663706127e-6

charge_c <- 1e-9
current_a <- 2.0

field_table <- tibble(
  radius_m = seq(0.02, 1.00, by = 0.01)
) %>%
  mutate(
    electric_field_n_per_c =
      charge_c / (4 * pi * epsilon0 * radius_m^2),
    electric_potential_v =
      charge_c / (4 * pi * epsilon0 * radius_m),
    magnetic_field_t =
      mu0 * current_a / (2 * pi * radius_m)
  )

measured_table <- read_csv(measurement_path, show_col_types = FALSE) %>%
  mutate(
    electric_field_theory_n_per_c =
      charge_c / (4 * pi * epsilon0 * radius_m^2),
    residual_n_per_c =
      electric_field_measured_n_per_c - electric_field_theory_n_per_c,
    percent_error =
      100 * residual_n_per_c / electric_field_theory_n_per_c
  )

summary_table <- measured_table %>%
  summarise(
    n_measurements = n(),
    mean_abs_residual = mean(abs(residual_n_per_c)),
    mean_abs_percent_error = mean(abs(percent_error))
  )

write_csv(field_table, field_output)
write_csv(measured_table, comparison_output)

print(head(field_table, 12))
print(measured_table)
print(summary_table)
cat("\nSaved field table to:", field_output, "\n")
cat("Saved comparison table to:", comparison_output, "\n")
