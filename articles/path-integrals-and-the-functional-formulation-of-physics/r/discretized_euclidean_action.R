# Discretized Euclidean Action for Sample Paths
#
# This workflow evaluates:
#
#   S_E = sum_n [
#       m / (2 Delta tau) * (x_{n+1} - x_n)^2
#       + Delta tau / 2 * m * omega^2 * x_n^2
#   ]

library(tidyverse)

article_dir <- "articles/path-integrals-and-the-functional-formulation-of-physics"

output_path <- file.path(article_dir, "data/computed_discretized_euclidean_action_r.csv")
summary_path <- file.path(article_dir, "data/computed_discretized_euclidean_action_summary_r.csv")

mass <- 1.0
omega <- 1.0
hbar <- 1.0
n_steps <- 100
beta <- 4.0
delta_tau <- beta / n_steps

time_grid <- tibble(
  step = 0:(n_steps - 1),
  tau = step * delta_tau
)

path_table <- time_grid %>%
  mutate(
    zero_path = 0.0,
    sine_path = sin(2 * pi * tau / beta),
    rough_path = sin(2 * pi * tau / beta) + 0.25 * sin(10 * pi * tau / beta)
  ) %>%
  pivot_longer(
    cols = c(zero_path, sine_path, rough_path),
    names_to = "path_name",
    values_to = "x"
  ) %>%
  group_by(path_name) %>%
  arrange(step, .by_group = TRUE) %>%
  mutate(
    x_next = lead(x, default = first(x)),
    kinetic_term =
      mass / (2 * delta_tau) * (x_next - x)^2,
    potential_term =
      delta_tau * 0.5 * mass * omega^2 * x^2,
    action_density =
      kinetic_term + potential_term
  ) %>%
  ungroup()

action_summary <- path_table %>%
  group_by(path_name) %>%
  summarise(
    euclidean_action = sum(action_density),
    path_weight = exp(-euclidean_action / hbar),
    mean_x = mean(x),
    mean_x_squared = mean(x^2),
    .groups = "drop"
  )

write_csv(path_table, output_path)
write_csv(action_summary, summary_path)

print(path_table)
print(action_summary)

cat("\nSaved path table to:", output_path, "\n")
cat("Saved action summary to:", summary_path, "\n")
