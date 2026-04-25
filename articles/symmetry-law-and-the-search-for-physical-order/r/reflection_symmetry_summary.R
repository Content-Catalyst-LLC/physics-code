# Reflection Symmetry Summary
#
# This workflow checks reflection invariance:
#
#   V(x) = V(-x)
#
# for a symmetric potential and compares it with an explicitly broken
# potential.

library(tidyverse)

input_path <- "articles/symmetry-law-and-the-search-for-physical-order/data/reflection_symmetry_sample.csv"
output_path <- "articles/symmetry-law-and-the-search-for-physical-order/data/reflection_symmetry_summary.csv"

reflection_data <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    reflected_x = -x,
    symmetric_potential = x^2,
    symmetric_potential_reflected = reflected_x^2,
    broken_potential = x^2 + epsilon * x,
    broken_potential_reflected = reflected_x^2 + epsilon * reflected_x,
    symmetric_difference = symmetric_potential - symmetric_potential_reflected,
    broken_difference = broken_potential - broken_potential_reflected
  )

summary_table <- reflection_data %>%
  summarise(
    n_points = n(),
    max_abs_symmetric_difference = max(abs(symmetric_difference)),
    max_abs_broken_difference = max(abs(broken_difference)),
    epsilon = first(epsilon)
  )

write_csv(summary_table, output_path)

print(reflection_data)
print(summary_table)
cat("\nSaved summary to:", output_path, "\n")
