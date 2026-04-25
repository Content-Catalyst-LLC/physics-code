# Parameter Sweep Diagnostics
#
# This workflow reads selected logistic map cases and summarizes long-run behavior.

library(tidyverse)

article_dir <- "articles/nonlinear-dynamics-chaos-and-complex-physical-systems"

input_path <- file.path(article_dir, "data/logistic_parameter_cases.csv")
output_path <- file.path(article_dir, "data/computed_parameter_sweep_diagnostics_r.csv")

iterate_case <- function(case_id, r, x0, n_iter, burn_in) {
  x <- numeric(n_iter)
  x[1] <- x0

  for (i in 2:n_iter) {
    x[i] <- r * x[i - 1] * (1 - x[i - 1])
  }

  tibble(
    case_id = case_id,
    r = r,
    iteration = seq_len(n_iter),
    x = x
  ) %>%
    filter(iteration > burn_in)
}

cases <- read_csv(input_path, show_col_types = FALSE)

diagnostics <- pmap_dfr(
  list(
    cases$case_id,
    cases$r,
    cases$x0,
    cases$n_iter,
    cases$burn_in
  ),
  iterate_case
) %>%
  group_by(case_id, r) %>%
  summarise(
    min_x = min(x),
    mean_x = mean(x),
    max_x = max(x),
    sd_x = sd(x),
    approximate_unique_states = n_distinct(round(x, 6)),
    .groups = "drop"
  )

write_csv(diagnostics, output_path)

print(diagnostics)
cat("\nSaved diagnostics to:", output_path, "\n")
