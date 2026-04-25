# Markov Jump Process and Entropy Production
#
# Computes cycle current, affinity, and entropy production for
# a three-state Markov cycle with clockwise rate k_plus and
# counterclockwise rate k_minus.

library(tidyverse)

article_dir <- "articles/nonequilibrium-statistical-mechanics"

cases <- read_csv(
  file.path(article_dir, "data/markov_cycle_cases.csv"),
  show_col_types = FALSE
)

compute_entropy_production <- function(k_plus, k_minus) {
  current <- (k_plus - k_minus) / 3

  if (k_plus > 0 && k_minus > 0) {
    affinity <- 3 * log(k_plus / k_minus)
    entropy_production <- current * affinity
  } else {
    affinity <- NA_real_
    entropy_production <- NA_real_
  }

  tibble(
    cycle_current = current,
    cycle_affinity_kb_units = affinity,
    entropy_production_rate_kb_units = entropy_production,
    detailed_balance = near(k_plus, k_minus)
  )
}

summary <- cases %>%
  mutate(result = map2(k_plus, k_minus, compute_entropy_production)) %>%
  select(case_id, k_plus, k_minus, notes, result) %>%
  unnest(result)

write_csv(
  summary,
  file.path(article_dir, "data/computed_markov_entropy_production_r.csv")
)

print(summary)
