# Kepler Log-Log Scaling Analysis
#
# This R workflow fits a log-log scaling model to approximate planetary
# orbital data.
#
# Kepler-style relation:
#   T = a^(3/2)
#
# Log form:
#   log(T) = beta_0 + beta_1 * log(a)
#
# Expected beta_1 is approximately 1.5.

library(tidyverse)
library(broom)

data_path <- "articles/scientific-revolution-physical-law/data/planetary_orbits_normalized.csv"
output_path <- "articles/scientific-revolution-physical-law/data/kepler_loglog_fit_summary.csv"

orbits <- read_csv(data_path, show_col_types = FALSE) %>%
  mutate(
    log_axis = log(semi_major_axis_au),
    log_period = log(orbital_period_years)
  )

kepler_fit <- lm(log_period ~ log_axis, data = orbits)

fit_summary <- tidy(kepler_fit) %>%
  mutate(
    expected_scaling_exponent = if_else(term == "log_axis", 1.5, NA_real_)
  )

model_glance <- glance(kepler_fit)

write_csv(fit_summary, output_path)

print(orbits)
print(fit_summary)
print(model_glance)
cat("\nSaved fit summary to:", output_path, "\n")
