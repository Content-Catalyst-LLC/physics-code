# Convergence Summary
#
# This workflow creates a simple convergence table for illustrative
# grid-refinement diagnostics.

library(tidyverse)

article_dir <- "articles/computational-physics-and-scientific-simulation"

output_path <- file.path(article_dir, "data/computed_convergence_summary_r.csv")

convergence_table <- tibble(
  n_grid = c(51, 101, 201, 401),
  dx_m = 1 / (n_grid - 1),
  illustrative_l2_error = c(1.8e-3, 4.5e-4, 1.1e-4, 2.8e-5)
) %>%
  mutate(
    error_ratio = illustrative_l2_error / lead(illustrative_l2_error),
    dx_ratio = dx_m / lead(dx_m),
    observed_order =
      log(error_ratio) / log(dx_ratio)
  )

write_csv(convergence_table, output_path)

print(convergence_table)
cat("\nSaved convergence summary to:", output_path, "\n")
