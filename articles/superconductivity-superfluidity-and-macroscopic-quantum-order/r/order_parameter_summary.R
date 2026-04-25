# Order Parameter Summary
#
# Reads the Ginzburg-Landau minimum table and summarizes amplitude behavior.

library(tidyverse)

article_dir <- "articles/superconductivity-superfluidity-and-macroscopic-quantum-order"

input_path <- file.path(article_dir, "data/computed_gl_minimum_table_r.csv")
output_path <- file.path(article_dir, "data/computed_order_parameter_summary_r.csv")

if (!file.exists(input_path)) {
  stop("Run r/ginzburg_landau_free_energy.R first.")
}

minimum_table <- read_csv(input_path, show_col_types = FALSE)

summary <- minimum_table %>%
  group_by(case_id) %>%
  summarise(
    max_equilibrium_amplitude = max(psi_amplitude),
    min_free_energy_density = min(free_energy_density),
    first_ordered_temperature_k = min(temperature_k[psi_amplitude > 0], na.rm = TRUE),
    .groups = "drop"
  )

write_csv(summary, output_path)

print(summary)
