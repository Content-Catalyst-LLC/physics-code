# Finite Group Decomposition for C3
#
# This workflow decomposes several reducible C3 characters.

library(tidyverse)

article_dir <- "articles/group-theory-and-representation-theory-in-physics"

input_path <- file.path(article_dir, "data/reducible_character_cases.csv")
output_path <- file.path(article_dir, "data/computed_finite_group_decomposition_r.csv")

omega <- exp(2i * pi / 3)

character_table <- tibble(
  irrep = c("Gamma_0", "Gamma_1", "Gamma_2"),
  e = c(1, 1, 1),
  r = c(1, omega, omega^2),
  r2 = c(1, omega^2, omega)
)

cases <- read_csv(input_path, show_col_types = FALSE)

decompose_case <- function(case_row) {
  reducible_character <- c(
    e = as.numeric(case_row$chi_e),
    r = as.numeric(case_row$chi_r),
    r2 = as.numeric(case_row$chi_r2)
  )

  character_table %>%
    rowwise() %>%
    mutate(
      case_id = case_row$case_id,
      group_id = case_row$group_id,
      multiplicity = Re(
        sum(
          Conj(as.complex(c(e, r, r2))) *
            as.complex(reducible_character)
        ) / 3
      )
    ) %>%
    ungroup() %>%
    select(case_id, group_id, irrep, multiplicity)
}

decomposition <- cases %>%
  split(seq_len(nrow(.))) %>%
  map_dfr(decompose_case)

write_csv(decomposition, output_path)

print(decomposition)
cat("\nSaved finite-group decomposition to:", output_path, "\n")
