# Projectile Trajectory Fitting and Residuals
#
# This workflow generates ideal projectile data, adds small measurement-style
# noise, fits a quadratic trajectory model, and summarizes residuals.

library(tidyverse)

article_dir <- "articles/motion-force-and-the-foundations-of-classical-mechanics"

trajectory_output <- file.path(article_dir, "data/computed_projectile_fit_table_r.csv")
summary_output <- file.path(article_dir, "data/computed_projectile_fit_summary_r.csv")

set.seed(42)

gravity_m_per_s2 <- 9.80665
initial_speed_m_per_s <- 12.0
launch_angle_rad <- pi / 4

time_s <- seq(0, 1.8, by = 0.05)

trajectory_table <- tibble(
  time_s = time_s
) %>%
  mutate(
    x_true_m =
      initial_speed_m_per_s * cos(launch_angle_rad) * time_s,
    y_true_m =
      initial_speed_m_per_s * sin(launch_angle_rad) * time_s -
      0.5 * gravity_m_per_s2 * time_s^2
  ) %>%
  filter(y_true_m >= 0) %>%
  mutate(
    x_measured_m = x_true_m + rnorm(n(), mean = 0, sd = 0.02),
    y_measured_m = y_true_m + rnorm(n(), mean = 0, sd = 0.02)
  )

quadratic_fit <- lm(
  y_measured_m ~ x_measured_m + I(x_measured_m^2),
  data = trajectory_table
)

fitted_table <- trajectory_table %>%
  mutate(
    y_fitted_m = predict(quadratic_fit, newdata = trajectory_table),
    residual_m = y_measured_m - y_fitted_m
  )

residual_summary <- fitted_table %>%
  summarise(
    n_points = n(),
    mean_residual_m = mean(residual_m),
    root_mean_square_residual_m = sqrt(mean(residual_m^2)),
    max_abs_residual_m = max(abs(residual_m))
  )

write_csv(fitted_table, trajectory_output)
write_csv(residual_summary, summary_output)

print(head(fitted_table, 12))
print(summary(quadratic_fit))
print(residual_summary)

cat("\nSaved fitted trajectory table to:", trajectory_output, "\n")
cat("Saved residual summary to:", summary_output, "\n")
