# Schwarzschild Radius and Gravitational Redshift
#
# This workflow computes:
#
#   r_s = 2 G M / c^2
#
# and:
#
#   1 + z = 1 / sqrt(1 - r_s / r)

library(tidyverse)

article_dir <- "articles/general-relativity-geometry-gravity-and-spacetime-curvature"

input_path <- file.path(article_dir, "data/compact_object_cases.csv")
output_path <- file.path(article_dir, "data/computed_schwarzschild_redshift_summary_r.csv")

gravitational_constant <- 6.67430e-11
speed_of_light <- 299792458

objects <- read_csv(input_path, show_col_types = FALSE)

summary_table <- objects %>%
  mutate(
    schwarzschild_radius_m =
      2 * gravitational_constant * mass_kg / speed_of_light^2,
    schwarzschild_radius_km = schwarzschild_radius_m / 1000,
    compactness = schwarzschild_radius_m / radius_m,
    redshift_factor = if_else(
      !is.na(radius_m) & radius_m > schwarzschild_radius_m,
      1 / sqrt(1 - schwarzschild_radius_m / radius_m),
      NA_real_
    ),
    gravitational_redshift_z = redshift_factor - 1
  )

write_csv(summary_table, output_path)

print(summary_table)
cat("\nSaved Schwarzschild/redshift summary to:", output_path, "\n")
