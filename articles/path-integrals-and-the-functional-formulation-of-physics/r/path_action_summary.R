# Path Action Summary
#
# This workflow reads deterministic path-action outputs if available
# and summarizes relative Euclidean weights.

library(tidyverse)

article_dir <- "articles/path-integrals-and-the-functional-formulation-of-physics"

input_path <- file.path(article_dir, "data/computed_discretized_path_actions.csv")
fallback_path <- file.path(article_dir, "data/computed_discretized_euclidean_action_summary_r.csv")
output_path <- file.path(article_dir, "data/computed_path_action_relative_weights_r.csv")

if (file.exists(input_path)) {
  actions <- read_csv(input_path, show_col_types = FALSE) %>%
    select(path_name, euclidean_action, path_weight, mean_x, mean_x_squared)
} else {
  actions <- read_csv(fallback_path, show_col_types = FALSE)
}

relative_summary <- actions %>%
  mutate(
    min_action = min(euclidean_action),
    action_above_minimum = euclidean_action - min_action,
    relative_weight = exp(-action_above_minimum)
  ) %>%
  arrange(euclidean_action)

write_csv(relative_summary, output_path)

print(relative_summary)
cat("\nSaved relative path weights to:", output_path, "\n")
