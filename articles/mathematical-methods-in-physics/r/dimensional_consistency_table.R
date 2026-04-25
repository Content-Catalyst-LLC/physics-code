# Dimensional Consistency Table
#
# This workflow stores a small catalog of dimensional relations.

library(tidyverse)

article_dir <- "articles/mathematical-methods-in-physics"

input_path <- file.path(article_dir, "data/dimensional_relations.csv")
output_path <- file.path(article_dir, "data/computed_dimensional_relations_summary_r.csv")

dimension_table <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    relation_category = case_when(
      str_detect(expected_dimension, "T\\^-") ~ "time-dependent",
      TRUE ~ "other"
    )
  )

write_csv(dimension_table, output_path)

print(dimension_table)
cat("\nSaved dimensional relations summary to:", output_path, "\n")
