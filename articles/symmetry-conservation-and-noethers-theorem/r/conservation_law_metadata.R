# Conservation Law Metadata
#
# This workflow joins mechanics systems with expected conserved quantities.

library(tidyverse)

article_dir <- "articles/symmetry-conservation-and-noethers-theorem"

input_path <- file.path(article_dir, "data/mechanics_system_cases.csv")
output_path <- file.path(article_dir, "data/computed_conservation_law_metadata_r.csv")

systems <- read_csv(input_path, show_col_types = FALSE)

conservation_summary <- systems %>%
  mutate(
    conservation_expected = !str_detect(expected_conserved_quantity, "not conserved"),
    symmetry_category = case_when(
      str_detect(symmetry, "time") ~ "time_related",
      str_detect(symmetry, "rotation") ~ "rotation_related",
      str_detect(symmetry, "translation") ~ "translation_related",
      TRUE ~ "mixed_or_broken"
    )
  )

write_csv(conservation_summary, output_path)

print(conservation_summary)
cat("\nSaved conservation metadata to:", output_path, "\n")
