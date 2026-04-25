# Uncertainty Budget Summary
#
# This workflow summarizes uncertainty components and computes
# root-sum-square combined uncertainty by unit group.

library(tidyverse)

article_dir <- "articles/experimental-physics-measurement-noise-calibration-and-inference"

input_path <- file.path(article_dir, "data/uncertainty_budget_cases.csv")
output_path <- file.path(article_dir, "data/computed_uncertainty_budget_summary_r.csv")

budget <- read_csv(input_path, show_col_types = FALSE)

summary <- budget %>%
  group_by(unit) %>%
  summarise(
    n_components = n(),
    combined_standard_uncertainty = sqrt(sum(standard_uncertainty^2)),
    expanded_uncertainty_k2 = 2 * combined_standard_uncertainty,
    type_a_components = sum(uncertainty_type == "Type A"),
    type_b_components = sum(uncertainty_type == "Type B"),
    .groups = "drop"
  )

write_csv(summary, output_path)

print(summary)
cat("\nSaved uncertainty budget summary to:", output_path, "\n")
