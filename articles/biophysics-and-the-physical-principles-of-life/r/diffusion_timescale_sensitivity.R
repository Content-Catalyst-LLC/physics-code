# Diffusion Time Scales Across Biological Lengths
#
# This workflow estimates one-dimensional diffusion time:
#
#   t ≈ L^2 / (2D)
#
# where:
#   L = distance
#   D = diffusion coefficient

library(tidyverse)

article_dir <- "articles/biophysics-and-the-physical-principles-of-life"

output_path <- file.path(article_dir, "data/computed_diffusion_timescale_sensitivity_r.csv")
summary_path <- file.path(article_dir, "data/computed_diffusion_timescale_summary_r.csv")

diffusion_grid <- crossing(
  length_um = c(0.1, 1, 10, 100, 1000),
  diffusion_coefficient_um2_s = c(0.01, 0.1, 1, 10, 100)
) %>%
  mutate(
    diffusion_time_s =
      length_um^2 / (2 * diffusion_coefficient_um2_s),
    diffusion_time_min = diffusion_time_s / 60,
    diffusion_time_hr = diffusion_time_s / 3600,
    scale_category = case_when(
      length_um < 1 ~ "molecular_or_subcellular",
      length_um < 20 ~ "cellular",
      length_um < 500 ~ "tissue_microenvironment",
      TRUE ~ "macroscopic"
    )
  )

summary_table <- diffusion_grid %>%
  group_by(scale_category) %>%
  summarise(
    min_time_s = min(diffusion_time_s),
    median_time_s = median(diffusion_time_s),
    max_time_s = max(diffusion_time_s),
    .groups = "drop"
  )

write_csv(diffusion_grid, output_path)
write_csv(summary_table, summary_path)

print(diffusion_grid)
print(summary_table)

cat("\nSaved diffusion grid to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
