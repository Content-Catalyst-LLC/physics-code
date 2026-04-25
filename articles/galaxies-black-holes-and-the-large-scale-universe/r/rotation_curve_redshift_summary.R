# Rotation Curves and Redshift Summary
#
# This workflow supports the article by summarizing schematic rotation-curve
# and redshift data.
#
# It is designed as teaching scaffolding, not as a calibrated survey pipeline.

library(tidyverse)

rotation_path <- "articles/galaxies-black-holes-and-the-large-scale-universe/data/rotation_curve_sample.csv"
redshift_path <- "articles/galaxies-black-holes-and-the-large-scale-universe/data/redshift_sample.csv"
environment_path <- "articles/galaxies-black-holes-and-the-large-scale-universe/data/cosmic_web_environment_sample.csv"

summary_output <- "articles/galaxies-black-holes-and-the-large-scale-universe/data/rotation_redshift_summary.csv"

rotation <- read_csv(rotation_path, show_col_types = FALSE) %>%
  mutate(
    velocity_difference_km_s = observed_velocity_km_s - luminous_model_velocity_km_s
  )

redshift <- read_csv(redshift_path, show_col_types = FALSE) %>%
  mutate(
    scale_factor = 1 / (1 + redshift)
  )

environment <- read_csv(environment_path, show_col_types = FALSE)

summary_table <- tibble(
  n_rotation_points = nrow(rotation),
  max_velocity_difference_km_s = max(rotation$velocity_difference_km_s),
  n_redshift_objects = nrow(redshift),
  max_redshift = max(redshift$redshift),
  min_scale_factor = min(redshift$scale_factor),
  n_environment_classes = n_distinct(environment$environment_class)
)

write_csv(summary_table, summary_output)

print(rotation)
print(redshift)
print(environment)
print(summary_table)
cat("\nSaved summary to:", summary_output, "\n")
