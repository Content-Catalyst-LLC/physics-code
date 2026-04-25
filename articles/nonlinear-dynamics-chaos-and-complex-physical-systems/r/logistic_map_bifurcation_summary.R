# Logistic Map Bifurcation Summary
#
# This workflow iterates:
#
#   x_{n+1} = r x_n (1 - x_n)
#
# across a range of r values. It discards transient iterations
# and summarizes the long-run states for each parameter value.

library(tidyverse)

article_dir <- "articles/nonlinear-dynamics-chaos-and-complex-physical-systems"

output_path <- file.path(article_dir, "data/computed_logistic_bifurcation_data_r.csv")
summary_path <- file.path(article_dir, "data/computed_logistic_bifurcation_summary_r.csv")

iterate_logistic_map <- function(r, x0 = 0.2, n_iter = 1200, burn_in = 800) {
  x <- numeric(n_iter)
  x[1] <- x0

  for (i in 2:n_iter) {
    x[i] <- r * x[i - 1] * (1 - x[i - 1])
  }

  tibble(
    iteration = seq_len(n_iter),
    r = r,
    x = x
  ) %>%
    filter(iteration > burn_in)
}

r_values <- seq(2.5, 4.0, by = 0.005)

bifurcation_data <- purrr::map_dfr(
  r_values,
  ~ iterate_logistic_map(r = .x)
)

bifurcation_summary <- bifurcation_data %>%
  group_by(r) %>%
  summarise(
    min_x = min(x),
    mean_x = mean(x),
    max_x = max(x),
    sd_x = sd(x),
    approximate_unique_states =
      n_distinct(round(x, 5)),
    .groups = "drop"
  ) %>%
  mutate(
    qualitative_region = case_when(
      r < 3.0 ~ "stable_fixed_point",
      r < 3.45 ~ "period_doubling_region",
      r < 3.57 ~ "higher_period_region",
      TRUE ~ "chaotic_or_mixed_region"
    )
  )

write_csv(bifurcation_data, output_path)
write_csv(bifurcation_summary, summary_path)

print(head(bifurcation_data, 12))
print(head(bifurcation_summary, 12))
print(tail(bifurcation_summary, 12))

cat("\nSaved bifurcation data to:", output_path, "\n")
cat("Saved bifurcation summary to:", summary_path, "\n")
