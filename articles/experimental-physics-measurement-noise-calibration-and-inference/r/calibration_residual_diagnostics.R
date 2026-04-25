# Calibration Curve and Residual Diagnostics
#
# This workflow fits:
#
#   reference_value = alpha + beta * instrument_reading + error

library(tidyverse)
library(broom)

article_dir <- "articles/experimental-physics-measurement-noise-calibration-and-inference"

input_path <- file.path(article_dir, "data/calibration_points.csv")
augmented_path <- file.path(article_dir, "data/computed_calibration_residuals_r.csv")
summary_path <- file.path(article_dir, "data/computed_calibration_summary_r.csv")

calibration_data <- read_csv(input_path, show_col_types = FALSE)

calibration_model <- lm(
  reference_value_v ~ instrument_reading_v,
  data = calibration_data
)

calibration_augmented <- augment(calibration_model) %>%
  rename(
    fitted_reference_v = .fitted,
    residual_v = .resid
  )

calibration_summary <- tidy(calibration_model)

residual_summary <- calibration_augmented %>%
  summarise(
    mean_residual_v = mean(residual_v),
    residual_sd_v = sd(residual_v),
    max_abs_residual_v = max(abs(residual_v)),
    root_mean_square_residual_v = sqrt(mean(residual_v^2))
  )

combined_summary <- calibration_summary %>%
  mutate(model = "linear_calibration")

write_csv(calibration_augmented, augmented_path)
write_csv(residual_summary, summary_path)

print(combined_summary)
print(residual_summary)
print(calibration_augmented)

cat("\nSaved calibration residuals to:", augmented_path, "\n")
cat("Saved residual summary to:", summary_path, "\n")
