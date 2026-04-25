# Measurement Residual Summary
#
# This workflow compares repeated pendulum measurements with the mean period
# and summarizes residual behavior.

library(tidyverse)

article_dir <- "articles/measurement-mathematics-and-the-structure-of-physical-inquiry"

input_path <- file.path(article_dir, "data/pendulum_measurements.csv")
output_path <- file.path(article_dir, "data/computed_measurement_residuals_r.csv")

residual_table <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    period_s = time_10_oscillations_s / 10,
    mean_period_s = mean(period_s),
    residual_s = period_s - mean_period_s,
    abs_residual_s = abs(residual_s)
  )

summary_table <- residual_table %>%
  summarise(
    n_trials = n(),
    mean_period_s = mean(period_s),
    sd_period_s = sd(period_s),
    rms_residual_s = sqrt(mean(residual_s^2)),
    max_abs_residual_s = max(abs_residual_s)
  )

write_csv(residual_table, output_path)

print(residual_table)
print(summary_table)
cat("\nSaved residual table to:", output_path, "\n")
