# Materials Property Summary
#
# This workflow summarizes sample material band gaps and metadata.

library(tidyverse)

band_gap_path <- "articles/condensed-matter-and-the-physics-of-materials/data/material_band_gap_sample.csv"
metadata_path <- "articles/condensed-matter-and-the-physics-of-materials/data/materials_property_metadata.csv"
output_path <- "articles/condensed-matter-and-the-physics-of-materials/data/materials_property_summary.csv"

band_gaps <- read_csv(band_gap_path, show_col_types = FALSE)
metadata <- read_csv(metadata_path, show_col_types = FALSE)

summary_table <- band_gaps %>%
  mutate(
    simplified_classification = case_when(
      band_gap_ev <= 0.05 ~ "metal_or_semimetal_like",
      band_gap_ev < 3.0 ~ "semiconductor_like",
      TRUE ~ "insulator_like"
    )
  ) %>%
  count(simplified_classification, name = "n_materials")

write_csv(summary_table, output_path)

print(band_gaps)
print(metadata)
print(summary_table)
cat("\nSaved summary to:", output_path, "\n")
