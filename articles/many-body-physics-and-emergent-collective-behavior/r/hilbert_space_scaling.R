# Hilbert-Space Scaling
#
# This workflow computes:
#
#   dimension = local_dimension ^ n_sites

library(tidyverse)

article_dir <- "articles/many-body-physics-and-emergent-collective-behavior"

input_path <- file.path(article_dir, "data/hilbert_space_cases.csv")
output_path <- file.path(article_dir, "data/computed_hilbert_space_scaling_r.csv")

bytes_per_complex128 <- 16

cases <- read_csv(input_path, show_col_types = FALSE)

scaling_table <- cases %>%
  rowwise() %>%
  mutate(n_sites = list(n_min:n_max)) %>%
  unnest(n_sites) %>%
  ungroup() %>%
  mutate(
    hilbert_dimension = local_dimension ^ n_sites,
    state_vector_memory_bytes_complex128 =
      hilbert_dimension * bytes_per_complex128,
    state_vector_memory_gb_complex128 =
      state_vector_memory_bytes_complex128 / 1e9,
    state_vector_memory_tb_complex128 =
      state_vector_memory_bytes_complex128 / 1e12
  )

write_csv(scaling_table, output_path)

print(scaling_table)
cat("\nSaved Hilbert-space scaling table to:", output_path, "\n")
