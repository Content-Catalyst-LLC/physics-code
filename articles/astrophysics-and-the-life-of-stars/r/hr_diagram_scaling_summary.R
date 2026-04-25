# H-R Diagram and Stellar Scaling Summary
#
# This workflow supports the article by summarizing a sample
# main-sequence table and computing approximate luminosity and lifetime
# scaling.
#
# The relations are educational approximations, not full stellar models.

library(tidyverse)

input_path <- "articles/astrophysics-and-the-life-of-stars/data/main_sequence_sample.csv"
output_path <- "articles/astrophysics-and-the-life-of-stars/data/hr_scaling_summary.csv"

stars <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    luminosity_solar_scaling = mass_solar^3.5,
    lifetime_relative_to_sun = mass_solar / luminosity_solar_scaling,
    log_luminosity = log10(luminosity_solar_scaling),
    log_temperature = log10(temperature_k)
  )

summary_table <- stars %>%
  summarise(
    n_spectral_examples = n(),
    minimum_mass_solar = min(mass_solar),
    maximum_mass_solar = max(mass_solar),
    minimum_temperature_k = min(temperature_k),
    maximum_temperature_k = max(temperature_k),
    minimum_luminosity_solar = min(luminosity_solar_scaling),
    maximum_luminosity_solar = max(luminosity_solar_scaling),
    shortest_relative_lifetime = min(lifetime_relative_to_sun),
    longest_relative_lifetime = max(lifetime_relative_to_sun)
  )

write_csv(summary_table, output_path)

print(stars)
print(summary_table)
cat("\nSaved summary to:", output_path, "\n")
