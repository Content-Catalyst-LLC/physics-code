# Material Property Summary
#
# This workflow computes common isotropic elastic property conversions:
#
#   G = E / [2(1 + nu)]
#   K = E / [3(1 - 2nu)]

library(tidyverse)

article_dir <- "articles/continuum-physics-and-material-behavior"

input_path <- file.path(article_dir, "data/material_properties.csv")
output_path <- file.path(article_dir, "data/computed_material_property_summary_r.csv")

material_summary <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    youngs_modulus_pa = youngs_modulus_gpa * 1e9,
    shear_modulus_gpa =
      youngs_modulus_gpa / (2 * (1 + poissons_ratio)),
    bulk_modulus_gpa =
      youngs_modulus_gpa / (3 * (1 - 2 * poissons_ratio)),
    specific_stiffness_m2_per_s2 =
      youngs_modulus_pa / density_kg_per_m3
  )

write_csv(material_summary, output_path)

print(material_summary)
cat("\nSaved material property summary to:", output_path, "\n")
