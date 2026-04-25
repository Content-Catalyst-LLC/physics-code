# Transport Resistivity Summary
#
# This workflow compares simplified metal-like and semiconductor-like
# resistivity trends across temperature.

library(tidyverse)

input_path <- "articles/condensed-matter-and-the-physics-of-materials/data/transport_sample.csv"
output_path <- "articles/condensed-matter-and-the-physics-of-materials/data/transport_resistivity_summary.csv"

transport <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    resistivity = case_when(
      material_class == "metal" ~
        base_resistivity * (1 + temperature_coefficient * (temperature_k - 300)),
      material_class == "semiconductor" ~
        base_resistivity * exp(activation_temperature / temperature_k),
      TRUE ~ NA_real_
    ),
    conductivity = 1 / resistivity
  )

summary_table <- transport %>%
  group_by(material_class) %>%
  summarise(
    n_points = n(),
    min_temperature_k = min(temperature_k),
    max_temperature_k = max(temperature_k),
    min_resistivity = min(resistivity),
    max_resistivity = max(resistivity),
    resistivity_at_300k = resistivity[temperature_k == 300][1],
    .groups = "drop"
  )

write_csv(summary_table, output_path)

print(transport)
print(summary_table)
cat("\nSaved summary to:", output_path, "\n")
