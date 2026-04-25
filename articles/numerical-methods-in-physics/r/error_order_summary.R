# Error Order Summary
#
# Reads a convergence table and summarizes the observed second-order region.

library(tidyverse)

article_dir <- "articles/numerical-methods-in-physics"

input_path <- file.path(article_dir, "data/computed_finite_difference_convergence_r.csv")
output_path <- file.path(article_dir, "data/computed_error_order_summary_r.csv")

if (!file.exists(input_path)) {
  stop("Run r/finite_difference_convergence.R first.")
}

convergence_table <- read_csv(input_path, show_col_types = FALSE)

summary <- convergence_table %>%
  filter(!is.na(observed_order), dx >= 2^-12, dx <= 2^-4) %>%
  summarise(
    mean_observed_order = mean(observed_order),
    min_observed_order = min(observed_order),
    max_observed_order = max(observed_order),
    min_error_in_window = min(absolute_error),
    max_error_in_window = max(absolute_error)
  )

write_csv(summary, output_path)

print(summary)
