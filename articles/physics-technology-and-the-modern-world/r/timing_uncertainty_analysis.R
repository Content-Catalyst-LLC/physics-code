# Timing Uncertainty and Infrastructure Error
#
# This workflow converts timing uncertainty into position uncertainty
# for an electromagnetic signal traveling at the speed of light.
#
# Relation:
#   delta_d = c * delta_t
#
# Variables:
#   c = speed of light in meters per second
#   delta_t = timing uncertainty in seconds
#   delta_d = position uncertainty in meters

library(tidyverse)

speed_of_light_m_per_s <- 299792458

input_path <- "articles/physics-technology-and-the-modern-world/data/timing_error_examples.csv"
output_path <- "articles/physics-technology-and-the-modern-world/data/timing_uncertainty_summary.csv"

timing_errors <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    timing_error_s = timing_error_ns * 1e-9,
    position_error_m = speed_of_light_m_per_s * timing_error_s
  )

summary_table <- timing_errors %>%
  summarise(
    n_cases = n(),
    minimum_position_error_m = min(position_error_m),
    maximum_position_error_m = max(position_error_m),
    mean_position_error_m = mean(position_error_m),
    median_position_error_m = median(position_error_m)
  )

write_csv(summary_table, output_path)

print(timing_errors)
print(summary_table)
cat("\nSaved summary to:", output_path, "\n")
