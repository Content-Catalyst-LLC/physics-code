# Binary Entropy and Measurement Uncertainty
#
# This workflow computes the Shannon entropy of a binary measurement:
#
#   H(p) = -p log2(p) - (1 - p) log2(1 - p)

library(tidyverse)

article_dir <- "articles/quantum-information-decoherence-and-measurement"

output_path <- file.path(article_dir, "data/computed_binary_entropy_measurement_uncertainty_r.csv")
summary_path <- file.path(article_dir, "data/computed_binary_entropy_summary_r.csv")

binary_entropy <- function(p) {
  ifelse(
    p == 0 | p == 1,
    0,
    -p * log2(p) - (1 - p) * log2(1 - p)
  )
}

measurement_table <- tibble(
  probability_one = seq(0, 1, by = 0.01)
) %>%
  mutate(
    probability_zero = 1 - probability_one,
    binary_entropy_bits = binary_entropy(probability_one),
    measurement_regime = case_when(
      binary_entropy_bits < 0.25 ~ "low_uncertainty",
      binary_entropy_bits < 0.75 ~ "moderate_uncertainty",
      TRUE ~ "high_uncertainty"
    )
  )

summary_table <- measurement_table %>%
  summarise(
    max_entropy_bits = max(binary_entropy_bits),
    probability_at_max_entropy =
      probability_one[which.max(binary_entropy_bits)],
    mean_entropy_bits = mean(binary_entropy_bits)
  )

write_csv(measurement_table, output_path)
write_csv(summary_table, summary_path)

print(measurement_table)
print(summary_table)

cat("\nSaved measurement table to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
