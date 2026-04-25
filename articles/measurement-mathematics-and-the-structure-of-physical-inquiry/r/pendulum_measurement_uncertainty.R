# Pendulum Measurement, Repeated Timing, and Uncertainty Propagation
#
# This workflow estimates gravitational acceleration from:
#
#   g = 4*pi^2*L / T^2
#
# and propagates first-order uncertainty from L and T.

library(tidyverse)

article_dir <- "articles/measurement-mathematics-and-the-structure-of-physical-inquiry"

input_path <- file.path(article_dir, "data/pendulum_measurements.csv")
output_path <- file.path(article_dir, "data/computed_pendulum_uncertainty_r.csv")

pendulum_data <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    period_s = time_10_oscillations_s / 10
  )

summary_table <- pendulum_data %>%
  summarise(
    n_trials = n(),
    length_m = first(length_m),
    mean_period_s = mean(period_s),
    sd_period_s = sd(period_s),
    se_period_s = sd_period_s / sqrt(n_trials)
  )

length_uncertainty_m <- 0.001

length_m <- summary_table$length_m
mean_period_s <- summary_table$mean_period_s
period_uncertainty_s <- summary_table$se_period_s

g_estimate_m_per_s2 <-
  4 * pi^2 * length_m / mean_period_s^2

partial_g_partial_length <-
  4 * pi^2 / mean_period_s^2

partial_g_partial_period <-
  -8 * pi^2 * length_m / mean_period_s^3

combined_uncertainty_g_m_per_s2 <- sqrt(
  (partial_g_partial_length^2) * (length_uncertainty_m^2) +
    (partial_g_partial_period^2) * (period_uncertainty_s^2)
)

result_table <- summary_table %>%
  mutate(
    length_uncertainty_m = length_uncertainty_m,
    period_uncertainty_s = period_uncertainty_s,
    g_estimate_m_per_s2 = g_estimate_m_per_s2,
    combined_uncertainty_g_m_per_s2 = combined_uncertainty_g_m_per_s2
  )

write_csv(result_table, output_path)

print(pendulum_data)
print(result_table)
cat("\nSaved pendulum uncertainty result to:", output_path, "\n")
