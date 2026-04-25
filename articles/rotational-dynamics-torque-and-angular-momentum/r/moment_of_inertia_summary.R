# Moment of Inertia Summary
#
# This workflow summarizes common moment-of-inertia forms and joins them
# to rolling-body cases where a beta value is available.

library(tidyverse)

article_dir <- "articles/rotational-dynamics-torque-and-angular-momentum"

shapes_path <- file.path(article_dir, "data/moment_of_inertia_shapes.csv")
rolling_path <- file.path(article_dir, "data/rolling_body_cases.csv")
output_path <- file.path(article_dir, "data/computed_moment_of_inertia_summary_r.csv")

shapes <- read_csv(shapes_path, show_col_types = FALSE)
rolling <- read_csv(rolling_path, show_col_types = FALSE)

summary_table <- rolling %>%
  mutate(
    moment_of_inertia_kg_m2 =
      beta * mass_kg * radius_m^2,
    normalized_inertia = moment_of_inertia_kg_m2 / (mass_kg * radius_m^2)
  ) %>%
  select(
    object,
    beta,
    mass_kg,
    radius_m,
    moment_of_inertia_kg_m2,
    normalized_inertia,
    notes
  )

write_csv(summary_table, output_path)

print(shapes)
print(summary_table)
cat("\nSaved moment of inertia summary to:", output_path, "\n")
