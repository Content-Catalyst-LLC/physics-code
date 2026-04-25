# Thermal Measurement Summary
#
# This workflow summarizes illustrative calorimetry-style measurements:
#
#   Q = m c Delta T
#
# and compares reported heat-added values with formula-based values.

library(tidyverse)

article_dir <- "articles/thermodynamics-and-the-physics-of-heat"

input_path <- file.path(article_dir, "data/thermal_measurements.csv")
output_path <- file.path(article_dir, "data/computed_thermal_measurement_summary_r.csv")

measurements <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    delta_temperature_k = final_temperature_k - initial_temperature_k,
    heat_formula_j =
      mass_kg * specific_heat_j_per_kg_k * delta_temperature_k,
    residual_j = heat_added_j - heat_formula_j,
    percent_error = 100 * residual_j / heat_formula_j
  )

summary_table <- measurements %>%
  summarise(
    n_measurements = n(),
    mean_heat_added_j = mean(heat_added_j),
    mean_abs_residual_j = mean(abs(residual_j)),
    mean_abs_percent_error = mean(abs(percent_error))
  )

write_csv(measurements, output_path)

print(measurements)
print(summary_table)
cat("\nSaved measurement summary to:", output_path, "\n")
