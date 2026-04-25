# Ideal-Gas Isothermal Expansion and Entropy Accounting
#
# This workflow computes:
#
#   P = nRT / V
#   W = nRT ln(V2/V1)
#   Delta S = nR ln(V2/V1)
#
# It also estimates work numerically from a pressure-volume table.

library(tidyverse)

article_dir <- "articles/thermodynamics-and-the-physics-of-heat"

path_output <- file.path(article_dir, "data/computed_isothermal_path_r.csv")
summary_output <- file.path(article_dir, "data/computed_isothermal_summary_r.csv")

amount_mol <- 1.0
gas_constant_j_per_mol_k <- 8.314462618
temperature_k <- 300.0

volume_table <- tibble(
  volume_m3 = seq(0.01, 0.10, length.out = 500)
) %>%
  mutate(
    pressure_pa =
      amount_mol * gas_constant_j_per_mol_k * temperature_k / volume_m3
  )

initial_volume_m3 <- 0.02
final_volume_m3 <- 0.08

work_exact_j <-
  amount_mol *
  gas_constant_j_per_mol_k *
  temperature_k *
  log(final_volume_m3 / initial_volume_m3)

entropy_change_j_per_k <-
  amount_mol *
  gas_constant_j_per_mol_k *
  log(final_volume_m3 / initial_volume_m3)

work_table <- volume_table %>%
  filter(
    volume_m3 >= initial_volume_m3,
    volume_m3 <= final_volume_m3
  ) %>%
  mutate(
    delta_volume_m3 = lead(volume_m3) - volume_m3,
    rectangle_work_j = pressure_pa * delta_volume_m3
  )

work_numeric_j <- sum(work_table$rectangle_work_j, na.rm = TRUE)

summary_table <- tibble(
  process = "reversible_isothermal_expansion",
  amount_mol = amount_mol,
  temperature_k = temperature_k,
  initial_volume_m3 = initial_volume_m3,
  final_volume_m3 = final_volume_m3,
  exact_work_j = work_exact_j,
  numeric_work_j = work_numeric_j,
  entropy_change_j_per_k = entropy_change_j_per_k,
  relative_work_error = (work_numeric_j - work_exact_j) / work_exact_j
)

write_csv(volume_table, path_output)
write_csv(summary_table, summary_output)

print(head(volume_table, 12))
print(summary_table)

cat("\nSaved path table to:", path_output, "\n")
cat("Saved summary table to:", summary_output, "\n")
