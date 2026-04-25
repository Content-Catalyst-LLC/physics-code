# SSH Winding Number
#
# Computes phase winding of:
#
#   q(k) = t1 + t2 exp(-ik)

library(tidyverse)

article_dir <- "articles/topological-matter-and-quantum-phases"

compute_winding <- function(t1, t2, n_grid = 2000) {
  k <- seq(-pi, pi, length.out = n_grid)

  q <- t1 + t2 * exp(-1i * k)

  phase <- Arg(q)
  unwrapped_phase <- phase

  for (i in 2:length(unwrapped_phase)) {
    delta <- unwrapped_phase[i] - unwrapped_phase[i - 1]

    if (delta > pi) {
      unwrapped_phase[i:length(unwrapped_phase)] <-
        unwrapped_phase[i:length(unwrapped_phase)] - 2 * pi
    }

    if (delta < -pi) {
      unwrapped_phase[i:length(unwrapped_phase)] <-
        unwrapped_phase[i:length(unwrapped_phase)] + 2 * pi
    }
  }

  raw_winding <- (last(unwrapped_phase) - first(unwrapped_phase)) / (2 * pi)

  tibble(
    t1 = t1,
    t2 = t2,
    raw_winding = raw_winding,
    winding_number = round(raw_winding),
    is_topological = abs(t2) > abs(t1)
  )
}

cases <- read_csv(
  file.path(article_dir, "data/ssh_parameter_cases.csv"),
  show_col_types = FALSE
)

winding_table <- cases %>%
  mutate(result = map2(t1, t2, compute_winding)) %>%
  select(case_id, notes, result) %>%
  unnest(result)

write_csv(
  winding_table,
  file.path(article_dir, "data/computed_ssh_winding_number_r.csv")
)

print(winding_table)
