# Ensemble Metadata Summary
#
# This workflow summarizes ensemble metadata for statistical physics examples.

library(tidyverse)

article_dir <- "articles/statistical-physics-and-the-emergence-of-macroscopic-order"

input_path <- file.path(article_dir, "data/ensemble_metadata.csv")
output_path <- file.path(article_dir, "data/computed_ensemble_summary_r.csv")

ensembles <- read_csv(input_path, show_col_types = FALSE)

summary_table <- ensembles %>%
  mutate(
    allows_particle_exchange = str_detect(allowed_to_fluctuate, regex("particle", ignore_case = TRUE)),
    allows_energy_fluctuation = str_detect(allowed_to_fluctuate, regex("energy", ignore_case = TRUE))
  ) %>%
  summarise(
    n_ensembles = n(),
    n_allowing_particle_exchange = sum(allows_particle_exchange),
    n_allowing_energy_fluctuation = sum(allows_energy_fluctuation),
    listed_ensembles = paste(ensemble, collapse = "; ")
  )

write_csv(summary_table, output_path)

print(ensembles)
print(summary_table)
cat("\nSaved ensemble summary to:", output_path, "\n")
