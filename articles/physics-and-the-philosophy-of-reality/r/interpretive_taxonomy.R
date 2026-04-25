# Interpretive Taxonomy and Ontological Commitments
#
# This workflow organizes philosophy-of-physics interpretations
# as structured data. It does not settle interpretation; it makes
# commitments explicit and comparable.

library(tidyverse)

taxonomy_path <- "articles/physics-and-the-philosophy-of-reality/data/interpretation_taxonomy.csv"
output_path <- "articles/physics-and-the-philosophy-of-reality/data/interpretation_taxonomy_summary.csv"

interpretations <- read_csv(taxonomy_path, show_col_types = FALSE)

summary_table <- interpretations %>%
  mutate(
    observer_independent_state = as.logical(observer_independent_state),
    realist_leaning = case_when(
      observer_independent_state ~ "stronger realist commitment",
      !observer_independent_state ~ "weaker or contextual realist commitment",
      TRUE ~ "unclear"
    )
  ) %>%
  arrange(desc(observer_independent_state), interpretation)

write_csv(summary_table, output_path)

print(summary_table)
cat("\nSaved summary to:", output_path, "\n")
