# Boltzmann Population Ratios for Molecular Rotation
#
# This workflow computes relative populations for rotational levels
# in a simplified rigid-rotor model:
#
#   E_J = B J (J + 1)

library(tidyverse)

article_dir <- "articles/atomic-molecular-and-optical-physics"

input_path <- file.path(article_dir, "data/molecular_rotor_cases.csv")
output_path <- file.path(article_dir, "data/computed_rotational_boltzmann_populations_r.csv")
summary_path <- file.path(article_dir, "data/computed_rotational_population_summary_r.csv")

boltzmann_cm_inv_per_k <- 0.69503476

compute_population <- function(case_id, rotational_constant_cm_inv, temperature_k, j_max) {
  tibble(J = 0:j_max) %>%
    mutate(
      case_id = case_id,
      temperature_k = temperature_k,
      rotational_constant_cm_inv = rotational_constant_cm_inv,
      degeneracy = 2 * J + 1,
      energy_cm_inv = rotational_constant_cm_inv * J * (J + 1),
      boltzmann_factor =
        exp(-energy_cm_inv / (boltzmann_cm_inv_per_k * temperature_k)),
      unnormalized_population = degeneracy * boltzmann_factor,
      normalized_population =
        unnormalized_population / sum(unnormalized_population)
    )
}

cases <- read_csv(input_path, show_col_types = FALSE)

population_table <- pmap_dfr(
  list(
    cases$case_id,
    cases$rotational_constant_cm_inv,
    cases$temperature_k,
    cases$j_max
  ),
  compute_population
)

population_summary <- population_table %>%
  group_by(case_id, temperature_k, rotational_constant_cm_inv) %>%
  summarise(
    most_populated_J = J[which.max(normalized_population)],
    max_population = max(normalized_population),
    mean_J = sum(J * normalized_population),
    .groups = "drop"
  )

write_csv(population_table, output_path)
write_csv(population_summary, summary_path)

print(population_table)
print(population_summary)

cat("\nSaved population table to:", output_path, "\n")
cat("Saved summary to:", summary_path, "\n")
