# Gravitational Time Dilation Outside a Spherical Mass
#
# This workflow computes the Schwarzschild radius and the Schwarzschild
# clock-rate factor for Earth as a weak-field example.

library(tidyverse)

output_path <- "articles/gravity-curvature-and-the-structure-of-spacetime/data/computed_time_dilation_radius_sweep_r.csv"

gravitational_constant <- 6.67430e-11
speed_of_light <- 299792458
earth_mass_kg <- 5.972e24

schwarzschild_radius <- 2 * gravitational_constant * earth_mass_kg / speed_of_light^2

radius_table <- tibble(
  radius_m = seq(7e6, 5e7, length.out = 500)
) %>%
  mutate(
    radius_km = radius_m / 1000,
    schwarzschild_radius_m = schwarzschild_radius,
    clock_factor = sqrt(1 - schwarzschild_radius_m / radius_m),
    fractional_time_difference = 1 - clock_factor
  )

summary_table <- radius_table %>%
  summarise(
    schwarzschild_radius_m = first(schwarzschild_radius_m),
    minimum_radius_km = min(radius_km),
    maximum_radius_km = max(radius_km),
    minimum_clock_factor = min(clock_factor),
    maximum_fractional_time_difference = max(fractional_time_difference)
  )

write_csv(radius_table, output_path)

print(head(radius_table, 10))
print(summary_table)
cat("\nSaved radius sweep to:", output_path, "\n")
