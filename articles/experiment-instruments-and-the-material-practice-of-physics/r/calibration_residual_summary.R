# Calibration Residual Summary
#
# This workflow fits a simple linear calibration model:
#
#   reference_value = slope * instrument_reading + intercept
#
# It then summarizes residuals.

library(tidyverse)
library(broom)

input_path <- "articles/experiment-instruments-and-the-material-practice-of-physics/data/calibration_data.csv"
output_path <- "articles/experiment-instruments-and-the-material-practice-of-physics/data/calibration_summary_r.csv"

calibration <- read_csv(input_path, show_col_types = FALSE)

fit <- lm(reference_value ~ instrument_reading, data = calibration)

residual_table <- calibration %>%
  mutate(
    calibrated_prediction = predict(fit, newdata = calibration),
    residual = reference_value - calibrated_prediction
  )

summary_table <- glance(fit) %>%
  bind_cols(
    tibble(
      residual_sd = sd(residual_table$residual),
      max_abs_residual = max(abs(residual_table$residual))
    )
  )

write_csv(summary_table, output_path)

print(tidy(fit))
print(residual_table)
print(summary_table)
cat("\nSaved summary to:", output_path, "\n")
