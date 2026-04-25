# Spacetime Model Summary
#
# This workflow summarizes model metadata for general-relativity examples.

library(tidyverse)

input_path <- "articles/gravity-curvature-and-the-structure-of-spacetime/data/spacetime_model_metadata.csv"
output_path <- "articles/gravity-curvature-and-the-structure-of-spacetime/data/computed_spacetime_model_summary.csv"

models <- read_csv(input_path, show_col_types = FALSE)

summary_table <- models %>%
  summarise(
    n_models = n(),
    n_with_metric_language = sum(str_detect(model, regex("metric", ignore_case = TRUE))),
    models_listed = paste(model, collapse = "; ")
  )

write_csv(summary_table, output_path)

print(models)
print(summary_table)
cat("\nSaved model summary to:", output_path, "\n")
