# Reynolds Number and Pipe-Flow Regime Classification
#
# This workflow computes:
#
#   Re = rho * v * L / mu

library(tidyverse)

article_dir <- "articles/fluid-dynamics-and-the-physics-of-flow"

fluid_path <- file.path(article_dir, "data/fluid_properties.csv")
case_path <- file.path(article_dir, "data/pipe_flow_cases.csv")
output_path <- file.path(article_dir, "data/computed_reynolds_number_classification_r.csv")

fluids <- read_csv(fluid_path, show_col_types = FALSE)
cases <- read_csv(case_path, show_col_types = FALSE)

flow_cases <- cases %>%
  left_join(fluids, by = "fluid") %>%
  mutate(
    reynolds_number =
      density_kg_per_m3 *
      velocity_m_per_s *
      characteristic_length_m /
      dynamic_viscosity_pa_s,
    kinematic_viscosity_m2_per_s =
      dynamic_viscosity_pa_s / density_kg_per_m3,
    flow_regime = case_when(
      reynolds_number < 2300 ~ "laminar",
      reynolds_number <= 4000 ~ "transitional",
      TRUE ~ "turbulent"
    )
  )

write_csv(flow_cases, output_path)

print(flow_cases)
cat("\nSaved Reynolds classification table to:", output_path, "\n")
