# Cross-Section Summary
#
# Reads angular integration output and summarizes numerical accuracy.

library(tidyverse)

article_dir <- "articles/scattering-theory-cross-sections-and-physical-inference"

input_path <- file.path(article_dir, "data/computed_angular_cross_section_integration_r.csv")
output_path <- file.path(article_dir, "data/computed_cross_section_summary_r.csv")

if (!file.exists(input_path)) {
  stop("Run r/angular_cross_section_integration.R first.")
}

summary <- read_csv(input_path, show_col_types = FALSE) %>%
  summarise(
    n_cases = n(),
    max_relative_error = max(relative_error),
    mean_total_cross_section = mean(sigma_total_numeric),
    min_total_cross_section = min(sigma_total_numeric),
    max_total_cross_section = max(sigma_total_numeric)
  )

write_csv(summary, output_path)

print(summary)
