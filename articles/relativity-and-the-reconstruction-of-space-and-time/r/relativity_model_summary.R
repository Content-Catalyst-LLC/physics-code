# Relativity Model Metadata Summary
#
# This workflow summarizes model metadata for special-relativity examples.

library(tidyverse)

input_path <- "articles/relativity-and-the-reconstruction-of-space-and-time/data/relativity_model_metadata.csv"
output_path <- "articles/relativity-and-the-reconstruction-of-space-and-time/data/computed_relativity_model_summary.csv"

models <- read_csv(input_path, show_col_types = FALSE)

summary_table <- models %>%
  summarise(
    n_models = n(),
    listed_models = paste(model_or_concept, collapse = "; "),
    n_with_invariant_language = sum(str_detect(primary_use, regex("invariant|transformation", ignore_case = TRUE)))
  )

write_csv(summary_table, output_path)

print(models)
print(summary_table)
cat("\nSaved model summary to:", output_path, "\n")
