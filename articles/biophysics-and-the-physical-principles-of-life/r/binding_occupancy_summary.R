# Binding Occupancy Summary
#
# This workflow computes:
#
#   theta = [L] / (KD + [L])

library(tidyverse)

article_dir <- "articles/biophysics-and-the-physical-principles-of-life"

input_path <- file.path(article_dir, "data/binding_cases.csv")
output_path <- file.path(article_dir, "data/computed_binding_occupancy_summary_r.csv")

cases <- read_csv(input_path, show_col_types = FALSE)

binding_table <- cases %>%
  rowwise() %>%
  mutate(
    ligand_concentration_m = list(
      10^seq(log10(ligand_min_m), log10(ligand_max_m), length.out = n_points)
    )
  ) %>%
  unnest(ligand_concentration_m) %>%
  ungroup() %>%
  mutate(
    fraction_bound = ligand_concentration_m / (kd_m + ligand_concentration_m),
    percent_bound = 100 * fraction_bound
  )

summary_table <- binding_table %>%
  group_by(case_id, kd_m) %>%
  summarise(
    min_percent_bound = min(percent_bound),
    max_percent_bound = max(percent_bound),
    ligand_at_near_half_m =
      ligand_concentration_m[which.min(abs(fraction_bound - 0.5))],
    .groups = "drop"
  )

write_csv(summary_table, output_path)

print(summary_table)
cat("\nSaved binding occupancy summary to:", output_path, "\n")
