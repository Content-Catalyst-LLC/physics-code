# Monte Carlo Uncertainty Propagation for Projectile Range
#
# This workflow estimates uncertainty in the ideal projectile range:
#
#   R = v^2 sin(2 theta) / g

library(tidyverse)

set.seed(42)

article_dir <- "articles/computational-physics-and-scientific-simulation"

output_path <- file.path(article_dir, "data/computed_projectile_uncertainty_samples_r.csv")
summary_path <- file.path(article_dir, "data/computed_projectile_uncertainty_summary_r.csv")

n_samples <- 10000
gravity_m_per_s2 <- 9.80665

simulation_samples <- tibble(
  sample_id = seq_len(n_samples),
  launch_speed_m_per_s = rnorm(
    n_samples,
    mean = 30.0,
    sd = 1.5
  ),
  launch_angle_deg = rnorm(
    n_samples,
    mean = 45.0,
    sd = 2.0
  )
) %>%
  mutate(
    launch_angle_rad = launch_angle_deg * pi / 180,
    range_m =
      launch_speed_m_per_s^2 *
      sin(2 * launch_angle_rad) /
      gravity_m_per_s2
  )

range_summary <- simulation_samples %>%
  summarise(
    samples = n(),
    mean_range_m = mean(range_m),
    sd_range_m = sd(range_m),
    p05_range_m = quantile(range_m, 0.05),
    median_range_m = median(range_m),
    p95_range_m = quantile(range_m, 0.95),
    min_range_m = min(range_m),
    max_range_m = max(range_m)
  )

write_csv(simulation_samples, output_path)
write_csv(range_summary, summary_path)

print(head(simulation_samples, 12))
print(range_summary)

cat("\nSaved samples to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
