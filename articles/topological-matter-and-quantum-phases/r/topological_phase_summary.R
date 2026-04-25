# Topological Phase Summary
#
# Summarizes phase examples by dimension and invariant type.

library(tidyverse)

article_dir <- "articles/topological-matter-and-quantum-phases"

phases <- read_csv(
  file.path(article_dir, "data/topological_phase_examples.csv"),
  show_col_types = FALSE
)

summary <- phases %>%
  count(dimension, key_invariant, sort = TRUE)

write_csv(
  summary,
  file.path(article_dir, "data/computed_topological_phase_summary_r.csv")
)

print(summary)
