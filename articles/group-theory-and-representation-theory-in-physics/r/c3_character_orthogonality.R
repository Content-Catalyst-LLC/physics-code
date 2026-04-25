# Character Orthogonality for C3
#
# This workflow constructs irreducible complex characters of C3
# and checks character orthogonality.

library(tidyverse)

article_dir <- "articles/group-theory-and-representation-theory-in-physics"

output_path <- file.path(article_dir, "data/computed_c3_character_orthogonality_r.csv")
decomposition_path <- file.path(article_dir, "data/computed_c3_decomposition_r.csv")

omega <- exp(2i * pi / 3)

character_table <- tibble(
  irrep = c("Gamma_0", "Gamma_1", "Gamma_2"),
  e = c(1, 1, 1),
  r = c(1, omega, omega^2),
  r2 = c(1, omega^2, omega)
)

group_elements <- c("e", "r", "r2")
group_order <- length(group_elements)

inner_product <- function(row_a, row_b) {
  values_a <- as.complex(unlist(row_a[group_elements]))
  values_b <- as.complex(unlist(row_b[group_elements]))

  sum(Conj(values_a) * values_b) / group_order
}

orthogonality_table <- expand_grid(
  irrep_a = character_table$irrep,
  irrep_b = character_table$irrep
) %>%
  rowwise() %>%
  mutate(
    inner_product = inner_product(
      character_table %>% filter(irrep == irrep_a),
      character_table %>% filter(irrep == irrep_b)
    ),
    inner_product_real = Re(inner_product),
    inner_product_imaginary = Im(inner_product)
  ) %>%
  ungroup()

reducible_character <- c(e = 3, r = 0, r2 = 0)

decomposition_table <- character_table %>%
  rowwise() %>%
  mutate(
    multiplicity = Re(
      sum(
        Conj(as.complex(c(e, r, r2))) *
          as.complex(reducible_character)
      ) / group_order
    )
  ) %>%
  ungroup() %>%
  select(irrep, multiplicity)

write_csv(
  orthogonality_table %>%
    mutate(inner_product = as.character(inner_product)),
  output_path
)

write_csv(decomposition_table, decomposition_path)

print(character_table)
print(orthogonality_table)
print(decomposition_table)

cat("\nSaved orthogonality table to:", output_path, "\n")
cat("Saved decomposition table to:", decomposition_path, "\n")
