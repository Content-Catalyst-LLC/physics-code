# Half-Life Estimation from Decay Counts
#
# This workflow estimates a decay constant and half-life from observed
# radioactive decay counts.
#
# Model:
#   N(t) = N0 * exp(-lambda * t)
#
# Taking logs:
#   log(N) = log(N0) - lambda * t
#
# The values are illustrative and should be replaced by calibrated
# activity or count data in a real nuclear-measurement workflow.

library(tidyverse)
library(broom)

input_path <- "articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/data/decay_counts_sample.csv"
output_path <- "articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/data/computed_half_life_fit_r.csv"

decay_data <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    log_counts = log(counts)
  )

fit <- lm(log_counts ~ time, data = decay_data)

lambda_estimate <- -coef(fit)[["time"]]
half_life_estimate <- log(2) / lambda_estimate

summary_table <- tibble(
  estimated_initial_log_count = coef(fit)[["(Intercept)"]],
  estimated_decay_constant = lambda_estimate,
  estimated_half_life = half_life_estimate,
  r_squared = summary(fit)$r.squared,
  residual_standard_error = glance(fit)$sigma
)

write_csv(summary_table, output_path)

print(decay_data)
print(tidy(fit))
print(summary_table)
cat("\nSaved half-life fit summary to:", output_path, "\n")
