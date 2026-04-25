# Zero-Dimensional Energy-Balance Sensitivity
#
# This workflow computes:
#
#   ASR = S0 * (1 - alpha) / 4
#   Te  = (ASR / sigma_sb)^(1/4)
#   Fco2 = 5.35 * log(C / C0)
#   DeltaT_eq = Fco2 / lambda

library(tidyverse)

article_dir <- "articles/climate-physics-and-planetary-energy-balance"

output_path <- file.path(article_dir, "data/computed_zero_dimensional_energy_balance_r.csv")
summary_path <- file.path(article_dir, "data/computed_zero_dimensional_energy_balance_summary_r.csv")

solar_constant_w_m2 <- 1361
stefan_boltzmann_w_m2_k4 <- 5.670374419e-8

co2_reference_ppm <- 280
co2_scenario_ppm <- c(280, 420, 560, 700)

parameter_grid <- crossing(
  planetary_albedo = c(0.25, 0.30, 0.35),
  feedback_parameter_w_m2_k = c(0.8, 1.2, 1.6),
  co2_ppm = co2_scenario_ppm
) %>%
  mutate(
    absorbed_shortwave_w_m2 =
      solar_constant_w_m2 * (1 - planetary_albedo) / 4,
    effective_emission_temperature_k =
      (absorbed_shortwave_w_m2 / stefan_boltzmann_w_m2_k4)^(1 / 4),
    co2_forcing_w_m2 =
      5.35 * log(co2_ppm / co2_reference_ppm),
    equilibrium_temperature_change_k =
      co2_forcing_w_m2 / feedback_parameter_w_m2_k
  )

sensitivity_summary <- parameter_grid %>%
  group_by(planetary_albedo, feedback_parameter_w_m2_k) %>%
  summarise(
    emission_temperature_k_at_reference =
      effective_emission_temperature_k[co2_ppm == co2_reference_ppm][1],
    warming_for_2x_co2_k =
      equilibrium_temperature_change_k[co2_ppm == 560][1],
    warming_for_700ppm_k =
      equilibrium_temperature_change_k[co2_ppm == 700][1],
    .groups = "drop"
  )

write_csv(parameter_grid, output_path)
write_csv(sensitivity_summary, summary_path)

print(parameter_grid)
print(sensitivity_summary)

cat("\nSaved parameter grid to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
