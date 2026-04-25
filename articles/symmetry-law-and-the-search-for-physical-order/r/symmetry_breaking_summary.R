# Symmetry-Breaking Potential Summary
#
# This workflow evaluates a double-well potential:
#
#   V(x) = -a*x^2 + b*x^4
#
# The potential is symmetric under x -> -x but has two nonzero minima.

library(tidyverse)

input_path <- "articles/symmetry-law-and-the-search-for-physical-order/data/symmetry_breaking_potential_sample.csv"
output_path <- "articles/symmetry-law-and-the-search-for-physical-order/data/symmetry_breaking_summary.csv"

potential_data <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    reflected_x = -x,
    double_well = -a * x^2 + b * x^4 + tilt * x,
    double_well_reflected = -a * reflected_x^2 + b * reflected_x^4 + tilt * reflected_x,
    reflection_difference = double_well - double_well_reflected
  )

summary_table <- potential_data %>%
  summarise(
    n_points = n(),
    minimum_potential = min(double_well),
    x_at_minimum = x[which.min(double_well)],
    max_abs_reflection_difference = max(abs(reflection_difference)),
    a = first(a),
    b = first(b),
    tilt = first(tilt)
  )

write_csv(summary_table, output_path)

print(potential_data)
print(summary_table)
cat("\nSaved summary to:", output_path, "\n")
