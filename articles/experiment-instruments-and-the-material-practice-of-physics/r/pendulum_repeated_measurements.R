# Pendulum Repeated Measurements
#
# This workflow summarizes repeated timing measurements and estimates:
#
#   g = 4*pi^2*L / T^2
#
# It is intended as transparent experimental-physics scaffolding.

library(tidyverse)

input_path <- "articles/experiment-instruments-and-the-material-practice-of-physics/data/pendulum_measurements.csv"
output_path <- "articles/experiment-instruments-and-the-material-practice-of-physics/data/pendulum_summary_r.csv"

measurements <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    period_s = time_for_10_oscillations_s / 10,
    u_period_s = u_time_for_10_oscillations_s / 10
  )

summary_table <- measurements %>%
  summarise(
    n_trials = n(),
    length_m = first(length_m),
    u_length_m = first(u_length_m),
    mean_period_s = mean(period_s),
    sd_period_s = sd(period_s),
    se_period_s = sd_period_s / sqrt(n_trials),
    estimated_g_m_s2 = 4 * pi^2 * length_m / mean_period_s^2
  )

write_csv(summary_table, output_path)

print(measurements)
print(summary_table)
cat("\nSaved summary to:", output_path, "\n")
