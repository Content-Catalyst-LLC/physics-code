# Kepler Period Law Summary
#
# This workflow checks the Newtonian form of Kepler's third law:
#
#   T^2 = 4*pi^2*a^3/mu
#
# and computes the ratio T^2/a^3 for sample orbits.

library(tidyverse)

article_dir <- "articles/gravitation-orbits-and-celestial-mechanics"

bodies_path <- file.path(article_dir, "data/central_bodies.csv")
cases_path <- file.path(article_dir, "data/orbital_cases.csv")
output_path <- file.path(article_dir, "data/computed_kepler_period_law_summary_r.csv")

bodies <- read_csv(bodies_path, show_col_types = FALSE)
cases <- read_csv(cases_path, show_col_types = FALSE)

period_table <- cases %>%
  left_join(
    bodies %>% select(body, mu_m3_per_s2, radius_m),
    by = c("central_body" = "body")
  ) %>%
  mutate(
    orbital_radius_m = radius_m + altitude_m,
    predicted_period_s =
      2 * pi * sqrt(semimajor_axis_m^3 / mu_m3_per_s2),
    period_squared_over_a_cubed =
      predicted_period_s^2 / semimajor_axis_m^3,
    expected_ratio =
      4 * pi^2 / mu_m3_per_s2,
    relative_ratio_error =
      (period_squared_over_a_cubed - expected_ratio) / expected_ratio
  )

write_csv(period_table, output_path)

print(period_table)
cat("\nSaved Kepler law summary to:", output_path, "\n")
