# Rolling Objects and Energy Partition
#
# This workflow compares ideal rolling objects using:
#
#   I = beta * M * R^2
#   a = g * sin(theta) / (1 + beta)
#   v = sqrt(2 * g * h / (1 + beta))

library(tidyverse)

article_dir <- "articles/rotational-dynamics-torque-and-angular-momentum"

input_path <- file.path(article_dir, "data/rolling_body_cases.csv")
output_path <- file.path(article_dir, "data/computed_rolling_energy_partition_r.csv")

gravity_m_per_s2 <- 9.80665

rolling_objects <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    incline_angle_rad = incline_angle_deg * pi / 180,
    acceleration_m_per_s2 =
      gravity_m_per_s2 * sin(incline_angle_rad) / (1 + beta),
    final_speed_m_per_s =
      sqrt(2 * gravity_m_per_s2 * height_drop_m / (1 + beta)),
    rotational_energy_fraction =
      beta / (1 + beta),
    translational_energy_fraction =
      1 / (1 + beta),
    moment_of_inertia_kg_m2 =
      beta * mass_kg * radius_m^2
  )

write_csv(rolling_objects, output_path)

print(rolling_objects)
cat("\nSaved rolling energy partition table to:", output_path, "\n")
