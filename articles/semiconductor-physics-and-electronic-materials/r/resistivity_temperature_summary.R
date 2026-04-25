# Resistivity and Temperature Summary
#
# This workflow computes idealized intrinsic carrier concentration and
# conductivity trends for sample material parameters.

library(tidyverse)

article_dir <- "articles/semiconductor-physics-and-electronic-materials"

input_path <- file.path(article_dir, "data/material_parameter_cases.csv")
output_path <- file.path(article_dir, "data/computed_resistivity_temperature_summary_r.csv")

boltzmann_ev_k <- 8.617333262145e-5
elementary_charge_c <- 1.602176634e-19

materials <- read_csv(input_path, show_col_types = FALSE)

temperature_grid <- crossing(
  materials,
  temperature_k = c(250, 300, 350, 400, 500)
) %>%
  mutate(
    intrinsic_carrier_cm3 =
      sqrt(nc_cm3 * nv_cm3) *
      exp(-band_gap_ev / (2 * boltzmann_ev_k * temperature_k)),
    intrinsic_carrier_m3 = intrinsic_carrier_cm3 * 1e6,
    electron_mobility_m2_v_s = electron_mobility_cm2_v_s * 1e-4,
    hole_mobility_m2_v_s = hole_mobility_cm2_v_s * 1e-4,
    intrinsic_conductivity_s_m =
      elementary_charge_c *
      intrinsic_carrier_m3 *
      (electron_mobility_m2_v_s + hole_mobility_m2_v_s),
    intrinsic_resistivity_ohm_m = 1 / intrinsic_conductivity_s_m
  )

write_csv(temperature_grid, output_path)

print(temperature_grid)
cat("\nSaved temperature summary to:", output_path, "\n")
