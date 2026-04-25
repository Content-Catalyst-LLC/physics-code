# Relativity Scale Summary
#
# This workflow summarizes weak-field and compact-object regimes.

library(tidyverse)

article_dir <- "articles/general-relativity-geometry-gravity-and-spacetime-curvature"

input_path <- file.path(article_dir, "data/compact_object_cases.csv")
output_path <- file.path(article_dir, "data/computed_relativity_scale_summary_r.csv")

gravitational_constant <- 6.67430e-11
speed_of_light <- 299792458

summary <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    schwarzschild_radius_m =
      2 * gravitational_constant * mass_kg / speed_of_light^2,
    compactness = schwarzschild_radius_m / radius_m,
    regime = case_when(
      is.na(radius_m) ~ "horizon_scale_reference",
      compactness < 1e-6 ~ "very_weak_field",
      compactness < 1e-3 ~ "weak_field",
      compactness < 0.1 ~ "moderately_relativistic",
      compactness < 1 ~ "strong_field",
      TRUE ~ "inside_or_at_horizon"
    )
  ) %>%
  group_by(regime) %>%
  summarise(
    number_of_cases = n(),
    min_schwarzschild_radius_m = min(schwarzschild_radius_m, na.rm = TRUE),
    max_schwarzschild_radius_m = max(schwarzschild_radius_m, na.rm = TRUE),
    .groups = "drop"
  )

write_csv(summary, output_path)

print(summary)
cat("\nSaved relativity scale summary to:", output_path, "\n")
