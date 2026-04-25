# Conductivity Sensitivity to Doping and Mobility
#
# This workflow estimates conductivity:
#
#   sigma = q n mu_n
#
# for n-type semiconductor cases where electron concentration is
# approximated by donor concentration.

library(tidyverse)

article_dir <- "articles/semiconductor-physics-and-electronic-materials"

output_path <- file.path(article_dir, "data/computed_conductivity_doping_sensitivity_r.csv")
summary_path <- file.path(article_dir, "data/computed_conductivity_doping_summary_r.csv")

elementary_charge_c <- 1.602176634e-19

parameter_grid <- crossing(
  donor_concentration_cm3 = c(1e14, 1e15, 1e16, 1e17, 1e18),
  electron_mobility_cm2_v_s = c(100, 500, 1000, 1400)
) %>%
  mutate(
    donor_concentration_m3 = donor_concentration_cm3 * 1e6,
    electron_mobility_m2_v_s = electron_mobility_cm2_v_s * 1e-4,
    conductivity_s_m =
      elementary_charge_c *
      donor_concentration_m3 *
      electron_mobility_m2_v_s,
    resistivity_ohm_m = 1 / conductivity_s_m,
    resistivity_ohm_cm = resistivity_ohm_m * 100
  )

conductivity_summary <- parameter_grid %>%
  group_by(donor_concentration_cm3) %>%
  summarise(
    min_resistivity_ohm_cm = min(resistivity_ohm_cm),
    max_resistivity_ohm_cm = max(resistivity_ohm_cm),
    mean_conductivity_s_m = mean(conductivity_s_m),
    .groups = "drop"
  )

write_csv(parameter_grid, output_path)
write_csv(conductivity_summary, summary_path)

print(parameter_grid)
print(conductivity_summary)

cat("\nSaved parameter grid to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
