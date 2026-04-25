# Finite Difference Convergence Study
#
# Tests the central difference derivative approximation:
#
#   u'(x) ≈ [u(x + dx) - u(x - dx)] / (2 dx)
#
# for u(x) = sin(x), whose exact derivative is cos(x).

library(tidyverse)

article_dir <- "articles/numerical-methods-in-physics"

target_x <- 1.0

convergence_table <- tibble(
  dx = 2 ^ seq(-2, -20, by = -1)
) %>%
  mutate(
    numeric_derivative = (sin(target_x + dx) - sin(target_x - dx)) / (2 * dx),
    exact_derivative = cos(target_x),
    absolute_error = abs(numeric_derivative - exact_derivative),
    observed_order = log(lag(absolute_error) / absolute_error) / log(lag(dx) / dx)
  )

write_csv(
  convergence_table,
  file.path(article_dir, "data/computed_finite_difference_convergence_r.csv")
)

print(convergence_table)
