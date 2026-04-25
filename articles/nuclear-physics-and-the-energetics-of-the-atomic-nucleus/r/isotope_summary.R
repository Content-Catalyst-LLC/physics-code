# Isotope Summary
#
# This workflow summarizes sample isotope metadata by stability and
# decay mode.

library(tidyverse)

input_path <- "articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/data/isotope_sample.csv"
output_path <- "articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/data/isotope_summary_r.csv"

isotopes <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    neutron_to_proton_ratio = if_else(Z > 0, N / Z, NA_real_),
    stability_class = if_else(decay_mode == "stable", "stable", "radioactive")
  )

summary_table <- isotopes %>%
  count(stability_class, decay_mode, name = "n_isotopes") %>%
  arrange(stability_class, decay_mode)

write_csv(summary_table, output_path)

print(isotopes)
print(summary_table)
cat("\nSaved isotope summary to:", output_path, "\n")
