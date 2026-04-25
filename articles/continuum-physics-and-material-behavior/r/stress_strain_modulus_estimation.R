# Stress-Strain Curve and Elastic Modulus Estimation
#
# This workflow estimates Young's modulus from an illustrative
# uniaxial stress-strain dataset.

library(tidyverse)

article_dir <- "articles/continuum-physics-and-material-behavior"

input_path <- file.path(article_dir, "data/stress_strain_test.csv")
output_path <- file.path(article_dir, "data/computed_stress_strain_modulus_estimation_r.csv")
summary_path <- file.path(article_dir, "data/computed_stress_strain_summary_r.csv")

stress_strain_data <- read_csv(input_path, show_col_types = FALSE) %>%
  mutate(
    stress_pa = stress_mpa * 1e6
  )

elastic_region <- stress_strain_data %>%
  filter(strain <= 0.0020)

elastic_fit <- lm(stress_pa ~ strain, data = elastic_region)

youngs_modulus_pa <- coef(elastic_fit)[["strain"]]
youngs_modulus_gpa <- youngs_modulus_pa / 1e9

processed <- stress_strain_data %>%
  arrange(strain) %>%
  mutate(
    previous_strain = lag(strain),
    previous_stress_pa = lag(stress_pa),
    delta_strain = strain - previous_strain,
    trapezoid_energy_density_j_per_m3 =
      0.5 * (stress_pa + previous_stress_pa) * delta_strain
  )

summary_table <- processed %>%
  summarise(
    estimated_youngs_modulus_gpa = youngs_modulus_gpa,
    max_stress_mpa = max(stress_mpa),
    max_strain = max(strain),
    approximate_strain_energy_density_j_per_m3 =
      sum(trapezoid_energy_density_j_per_m3, na.rm = TRUE)
  )

write_csv(processed, output_path)
write_csv(summary_table, summary_path)

print(processed)
print(summary_table)

cat("\nSaved processed stress-strain table to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
