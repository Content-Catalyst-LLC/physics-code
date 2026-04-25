# Decoherence Summary
#
# This workflow computes simple dephasing summaries:
#
#   coherence(t) = coherence(0) exp(-t/T2)

library(tidyverse)

article_dir <- "articles/quantum-information-decoherence-and-measurement"

input_path <- file.path(article_dir, "data/decoherence_parameter_cases.csv")
output_path <- file.path(article_dir, "data/computed_decoherence_summary_r.csv")

cases <- read_csv(input_path, show_col_types = FALSE)

decoherence_table <- cases %>%
  crossing(time_fraction_of_t2 = seq(0, 5, by = 0.25)) %>%
  mutate(
    time_seconds = time_fraction_of_t2 * t2_seconds,
    coherence_factor = exp(-time_seconds / t2_seconds),
    excited_population_factor = exp(-time_seconds / t1_seconds)
  )

summary_table <- decoherence_table %>%
  group_by(case_id) %>%
  summarise(
    t2_seconds = first(t2_seconds),
    t1_seconds = first(t1_seconds),
    coherence_after_one_t2 = coherence_factor[which.min(abs(time_fraction_of_t2 - 1))],
    coherence_after_five_t2 = coherence_factor[which.max(time_fraction_of_t2)],
    .groups = "drop"
  )

write_csv(summary_table, output_path)

print(summary_table)
cat("\nSaved decoherence summary to:", output_path, "\n")
