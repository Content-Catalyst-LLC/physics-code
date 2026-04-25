# Trajectory Measurement Residuals
#
# This workflow loads measurement-style projectile data and compares it to
# an ideal projectile model using the recorded time values.

library(tidyverse)

article_dir <- "articles/motion-force-and-the-foundations-of-classical-mechanics"

input_path <- file.path(article_dir, "data/trajectory_measurements.csv")
output_path <- file.path(article_dir, "data/computed_trajectory_measurement_residuals_r.csv")

gravity_m_per_s2 <- 9.80665
initial_speed_m_per_s <- 12.0
launch_angle_rad <- pi / 4

residual_table <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    x_model_m =
      initial_speed_m_per_s * cos(launch_angle_rad) * time_s,
    y_model_m =
      initial_speed_m_per_s * sin(launch_angle_rad) * time_s -
      0.5 * gravity_m_per_s2 * time_s^2,
    x_residual_m = x_measured_m - x_model_m,
    y_residual_m = y_measured_m - y_model_m,
    radial_residual_m = sqrt(x_residual_m^2 + y_residual_m^2)
  )

summary_table <- residual_table %>%
  summarise(
    n_points = n(),
    mean_x_residual_m = mean(x_residual_m),
    mean_y_residual_m = mean(y_residual_m),
    rms_radial_residual_m = sqrt(mean(radial_residual_m^2)),
    max_radial_residual_m = max(radial_residual_m)
  )

write_csv(residual_table, output_path)

print(residual_table)
print(summary_table)
cat("\nSaved residual table to:", output_path, "\n")
