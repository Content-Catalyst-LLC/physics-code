# Standard Model Particle Summary
#
# This workflow summarizes a small Standard Model particle metadata table by
# category and interaction flags.

library(tidyverse)

input_path <- "articles/quantum-fields-particles-and-the-standard-model/data/standard_model_particles.csv"
output_path <- "articles/quantum-fields-particles-and-the-standard-model/data/standard_model_particle_summary.csv"

particles <- read_csv(input_path, show_col_types = FALSE)

summary_table <- particles %>%
  group_by(category) %>%
  summarise(
    n_particles = n(),
    mean_spin = mean(spin),
    min_charge_e = min(charge_e),
    max_charge_e = max(charge_e),
    participates_strong = any(strong_interaction %in% c("yes", "mediator")),
    participates_weak = any(weak_interaction %in% c("yes", "mediator", "indirect")),
    participates_electromagnetic = any(electromagnetic_interaction %in% c("yes", "mediator")),
    .groups = "drop"
  )

write_csv(summary_table, output_path)

print(particles)
print(summary_table)
cat("\nSaved particle summary to:", output_path, "\n")
