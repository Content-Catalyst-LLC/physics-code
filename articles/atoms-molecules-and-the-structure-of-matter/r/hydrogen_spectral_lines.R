# Hydrogen Spectral Lines and Photon Energies
#
# This workflow converts selected hydrogen Balmer-series wavelengths into
# photon energies using:
#
#   E = h*c/lambda
#
# The values are illustrative and should be replaced by calibrated spectral
# measurements or evaluated line data in precision work.

library(tidyverse)

input_path <- "articles/atoms-molecules-and-the-structure-of-matter/data/hydrogen_spectral_lines.csv"
output_path <- "articles/atoms-molecules-and-the-structure-of-matter/data/computed_hydrogen_spectral_energies.csv"

planck_constant_j_s <- 6.62607015e-34
speed_of_light_m_s <- 299792458
joule_per_ev <- 1.602176634e-19

spectral_lines <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    wavelength_m = wavelength_nm * 1e-9,
    energy_j = planck_constant_j_s * speed_of_light_m_s / wavelength_m,
    energy_ev = energy_j / joule_per_ev
  )

summary_table <- spectral_lines %>%
  summarise(
    n_lines = n(),
    minimum_energy_ev = min(energy_ev),
    maximum_energy_ev = max(energy_ev),
    mean_energy_ev = mean(energy_ev)
  )

write_csv(spectral_lines, output_path)

print(spectral_lines)
print(summary_table)
cat("\nSaved spectral energy table to:", output_path, "\n")
