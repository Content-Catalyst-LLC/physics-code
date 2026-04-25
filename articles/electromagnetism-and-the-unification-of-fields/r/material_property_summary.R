# Material Property Summary
#
# This workflow summarizes approximate material electromagnetic properties.

library(tidyverse)

article_dir <- "articles/electromagnetism-and-the-unification-of-fields"

input_path <- file.path(article_dir, "data/material_properties.csv")
output_path <- file.path(article_dir, "data/computed_material_property_summary_r.csv")

materials <- read_csv(input_path, show_col_types = FALSE)

summary_table <- materials %>%
  mutate(
    conductivity_class = case_when(
      conductivity_s_per_m > 1e6 ~ "high conductor",
      conductivity_s_per_m > 1e-6 ~ "moderate/variable conductor",
      TRUE ~ "insulator or very low conductivity"
    )
  ) %>%
  group_by(conductivity_class) %>%
  summarise(
    n_materials = n(),
    median_relative_permittivity = median(relative_permittivity),
    median_relative_permeability = median(relative_permeability),
    .groups = "drop"
  )

write_csv(summary_table, output_path)

print(materials)
print(summary_table)
cat("\nSaved material summary to:", output_path, "\n")
