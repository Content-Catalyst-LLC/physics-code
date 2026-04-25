# Fluid Properties Summary
#
# This workflow computes kinematic viscosity from:
#
#   nu = mu / rho
#
# and prepares a compact fluid-property table for modeling workflows.

library(tidyverse)

article_dir <- "articles/fluid-dynamics-and-the-physics-of-flow"

input_path <- file.path(article_dir, "data/fluid_properties.csv")
output_path <- file.path(article_dir, "data/computed_fluid_properties_summary_r.csv")

fluid_summary <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    kinematic_viscosity_m2_per_s =
      dynamic_viscosity_pa_s / density_kg_per_m3,
    log10_dynamic_viscosity =
      log10(dynamic_viscosity_pa_s),
    log10_kinematic_viscosity =
      log10(kinematic_viscosity_m2_per_s)
  )

write_csv(fluid_summary, output_path)

print(fluid_summary)
cat("\nSaved fluid properties summary to:", output_path, "\n")
