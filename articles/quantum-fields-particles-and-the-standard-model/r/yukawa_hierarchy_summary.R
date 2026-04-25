# Fermion Masses and Yukawa Hierarchy
#
# This workflow computes schematic Yukawa couplings using:
#
#   y_f = sqrt(2) * m_f / v
#
# where:
#   y_f = Yukawa coupling
#   m_f = fermion mass in GeV
#   v   = Higgs vacuum expectation value, approximately 246 GeV
#
# Values are illustrative and should be replaced by a consistent evaluated
# particle-property table in precision work.

library(tidyverse)

input_path <- "articles/quantum-fields-particles-and-the-standard-model/data/fermion_mass_sample.csv"
output_path <- "articles/quantum-fields-particles-and-the-standard-model/data/yukawa_hierarchy_summary.csv"

higgs_vev_gev <- 246

fermions <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    yukawa_coupling = sqrt(2) * mass_gev / higgs_vev_gev,
    log10_yukawa = log10(yukawa_coupling)
  )

summary_table <- fermions %>%
  group_by(sector) %>%
  summarise(
    n_particles = n(),
    minimum_yukawa = min(yukawa_coupling),
    maximum_yukawa = max(yukawa_coupling),
    hierarchy_ratio = maximum_yukawa / minimum_yukawa,
    .groups = "drop"
  )

write_csv(summary_table, output_path)

print(fermions)
print(summary_table)
cat("\nSaved Yukawa summary to:", output_path, "\n")
