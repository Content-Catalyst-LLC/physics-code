# Cosmic Inventory and BSM Motivation
#
# This workflow summarizes a broad cosmological motivation for
# beyond-the-Standard-Model physics.

library(tidyverse)

inventory_path <- "articles/physics-beyond-the-standard-model/data/cosmic_inventory.csv"
candidates_path <- "articles/physics-beyond-the-standard-model/data/bsm_candidate_classes.csv"
output_path <- "articles/physics-beyond-the-standard-model/data/cosmic_inventory_summary.csv"

cosmic_inventory <- read_csv(inventory_path, show_col_types = FALSE)
candidate_classes <- read_csv(candidates_path, show_col_types = FALSE)

summary_table <- cosmic_inventory %>%
  summarise(
    ordinary_matter_percent = fraction_percent[component == "Ordinary matter"],
    dark_matter_percent = fraction_percent[component == "Dark matter"],
    dark_energy_percent = fraction_percent[component == "Dark energy"],
    nonordinary_component_percent = sum(fraction_percent[component != "Ordinary matter"])
  )

candidate_summary <- candidate_classes %>%
  count(problem_addressed, name = "candidate_class_count") %>%
  arrange(desc(candidate_class_count))

write_csv(summary_table, output_path)

print(cosmic_inventory)
print(summary_table)
print(candidate_summary)
cat("\nSaved summary to:", output_path, "\n")
