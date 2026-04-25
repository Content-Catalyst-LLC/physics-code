# Pendulum Measurement Uncertainty
#
# This R workflow supports repeated-measurement analysis.
# It estimates mean observed period, standard deviation,
# standard error, model prediction, and mean residual by pendulum length.

library(tidyverse)

gravity_m_per_s2 <- 9.80665

ideal_pendulum_period <- function(length_m) {
  2 * pi * sqrt(length_m / gravity_m_per_s2)
}

data_path <- "articles/what-is-physics/data/pendulum_measurements.csv"
output_path <- "articles/what-is-physics/data/pendulum_uncertainty_summary.csv"

measurements <- read_csv(data_path, show_col_types = FALSE) %>%
  mutate(
    predicted_period_s = ideal_pendulum_period(length_m),
    residual_s = period_s - predicted_period_s,
    percent_error = 100 * residual_s / predicted_period_s
  )

summary_by_length <- measurements %>%
  group_by(length_m) %>%
  summarise(
    n_trials = n(),
    mean_observed_period_s = mean(period_s),
    sd_observed_period_s = sd(period_s),
    standard_error_s = sd_observed_period_s / sqrt(n_trials),
    predicted_period_s = mean(predicted_period_s),
    mean_residual_s = mean(residual_s),
    mean_percent_error = mean(percent_error),
    .groups = "drop"
  )

write_csv(summary_by_length, output_path)

print(measurements)
print(summary_by_length)
cat("\nSaved uncertainty summary to:", output_path, "\n")
