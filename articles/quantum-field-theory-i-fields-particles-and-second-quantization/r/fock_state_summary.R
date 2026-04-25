# Fock State Summary
#
# This workflow summarizes oscillator energies:
#
#   E_n = hbar omega (n + 1/2)

library(tidyverse)

article_dir <- "articles/quantum-field-theory-i-fields-particles-and-second-quantization"

input_path <- file.path(article_dir, "data/fock_mode_cases.csv")
output_path <- file.path(article_dir, "data/computed_fock_state_summary_r.csv")

cases <- read_csv(input_path, show_col_types = FALSE)

summary <- cases %>%
  rowwise() %>%
  mutate(n = list(0:(fock_dimension - 1))) %>%
  unnest(n) %>%
  ungroup() %>%
  mutate(
    energy = hbar * omega * (n + 0.5),
    number_eigenvalue = n
  )

write_csv(summary, output_path)

print(summary)
cat("\nSaved Fock state summary to:", output_path, "\n")
