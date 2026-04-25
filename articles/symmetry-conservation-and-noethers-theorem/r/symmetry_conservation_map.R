# Symmetry-to-Conservation Mapping
#
# This workflow creates a structured table connecting
# continuous symmetries to their Noether conserved quantities.

library(tidyverse)

article_dir <- "articles/symmetry-conservation-and-noethers-theorem"

input_path <- file.path(article_dir, "data/symmetry_conservation_cases.csv")
output_path <- file.path(article_dir, "data/computed_symmetry_conservation_map_r.csv")
summary_path <- file.path(article_dir, "data/computed_symmetry_conservation_summary_r.csv")

symmetry_table <- read_csv(input_path, show_col_types = FALSE)

summary_table <- symmetry_table %>%
  count(theorem_context, name = "number_of_examples") %>%
  arrange(desc(number_of_examples))

write_csv(symmetry_table, output_path)
write_csv(summary_table, summary_path)

print(symmetry_table)
print(summary_table)

cat("\nSaved symmetry map to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
