# Equilibrium Warming Sensitivity
#
# This workflow evaluates:
#
#   DeltaT_eq = F / lambda

library(tidyverse)

article_dir <- "articles/climate-physics-and-planetary-energy-balance"

output_path <- file.path(article_dir, "data/computed_equilibrium_warming_sensitivity_r.csv")

co2_reference_ppm <- 280

sensitivity <- crossing(
  co2_ppm = seq(280, 800, by = 20),
  feedback_parameter_w_m2_k = seq(0.6, 2.0, by = 0.2)
) %>%
  mutate(
    forcing_w_m2 = 5.35 * log(co2_ppm / co2_reference_ppm),
    equilibrium_warming_k = forcing_w_m2 / feedback_parameter_w_m2_k
  )

write_csv(sensitivity, output_path)

print(head(sensitivity, 20))
print(tail(sensitivity, 20))

cat("\nSaved equilibrium warming sensitivity to:", output_path, "\n")
