# Scientific ML Audit Summary
#
# Reads residual diagnostics and creates a compact audit table.

library(tidyverse)

article_dir <- "articles/physics-informed-machine-learning-and-scientific-computing"

input_path <- file.path(article_dir, "data/computed_heat_residual_summary_r.csv")
output_path <- file.path(article_dir, "data/computed_sciml_audit_summary_r.csv")

if (!file.exists(input_path)) {
  stop("Run r/heat_equation_residual_diagnostics.R first.")
}

audit <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    residual_quality_flag = case_when(
      root_mean_squared_residual < 1e-4 ~ "excellent_for_grid",
      root_mean_squared_residual < 1e-3 ~ "acceptable_for_grid",
      TRUE ~ "needs_review"
    )
  )

write_csv(audit, output_path)

print(audit)
