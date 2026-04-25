# Markov Parameter Sweep
#
# Sweeps k_plus/k_minus ratios for a three-state cycle and computes
# entropy production in k_B units.

library(tidyverse)

article_dir <- "articles/nonequilibrium-statistical-mechanics"

sweep <- tibble(
  k_minus = 1.0,
  k_plus = exp(seq(log(0.2), log(10), length.out = 100))
) %>%
  mutate(
    cycle_current = (k_plus - k_minus) / 3,
    cycle_affinity_kb_units = 3 * log(k_plus / k_minus),
    entropy_production_rate_kb_units = cycle_current * cycle_affinity_kb_units
  )

write_csv(
  sweep,
  file.path(article_dir, "data/computed_markov_parameter_sweep_r.csv")
)

print(head(sweep, 10))
print(tail(sweep, 10))
