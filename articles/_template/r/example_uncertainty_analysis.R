library(dplyr)

measurements <- tibble::tibble(
  trial = 1:5,
  measured_value = c(9.79, 9.81, 9.80, 9.83, 9.78)
)

summary <- measurements %>%
  summarise(
    mean_value = mean(measured_value),
    sd_value = sd(measured_value),
    standard_error = sd_value / sqrt(n())
  )

print(summary)
