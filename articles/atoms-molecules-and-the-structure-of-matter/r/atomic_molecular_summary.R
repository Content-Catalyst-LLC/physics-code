# Atomic and Molecular Metadata Summary
#
# This workflow summarizes sample molecular metadata and structural relations.

library(tidyverse)

molecule_path <- "articles/atoms-molecules-and-the-structure-of-matter/data/molecule_sample.csv"
relation_path <- "articles/atoms-molecules-and-the-structure-of-matter/data/structural_relation_metadata.csv"
output_path <- "articles/atoms-molecules-and-the-structure-of-matter/data/atomic_molecular_summary.csv"

molecules <- read_csv(molecule_path, show_col_types = FALSE)
relations <- read_csv(relation_path, show_col_types = FALSE)

summary_table <- molecules %>%
  group_by(geometry, polarity) %>%
  summarise(
    n_molecules = n(),
    mean_atoms = mean(atoms),
    .groups = "drop"
  )

write_csv(summary_table, output_path)

print(molecules)
print(relations)
print(summary_table)
cat("\nSaved atomic/molecular summary to:", output_path, "\n")
