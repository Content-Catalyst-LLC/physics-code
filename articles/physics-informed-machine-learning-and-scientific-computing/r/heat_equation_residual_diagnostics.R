# Heat Equation Residual Diagnostics
#
# Evaluates:
#
#   r(x,t) = u_t - D u_xx
#
# for:
#
#   u(x,t) = exp(-D*pi^2*t) sin(pi*x)

library(tidyverse)

article_dir <- "articles/physics-informed-machine-learning-and-scientific-computing"

cases <- read_csv(
  file.path(article_dir, "data/heat_residual_cases.csv"),
  show_col_types = FALSE
)

run_case <- function(case_id, diffusion, n_x, n_t, notes) {
  x_grid <- seq(0, 1, length.out = n_x)
  t_grid <- seq(0, 1, length.out = n_t)

  dx <- x_grid[2] - x_grid[1]
  dt <- t_grid[2] - t_grid[1]

  field_table <- expand.grid(
    x = x_grid,
    t = t_grid
  ) %>%
    as_tibble() %>%
    mutate(
      u = exp(-diffusion * pi^2 * t) * sin(pi * x)
    )

  u_matrix <- matrix(
    field_table$u,
    nrow = n_x,
    ncol = n_t,
    byrow = FALSE
  )

  residual_rows <- list()
  row_index <- 1

  for (i in 2:(n_x - 1)) {
    for (j in 2:(n_t - 1)) {
      u_t <- (u_matrix[i, j + 1] - u_matrix[i, j - 1]) / (2 * dt)

      u_xx <- (
        u_matrix[i + 1, j] -
          2 * u_matrix[i, j] +
          u_matrix[i - 1, j]
      ) / dx^2

      residual <- u_t - diffusion * u_xx

      residual_rows[[row_index]] <- tibble(
        case_id = case_id,
        x = x_grid[i],
        t = t_grid[j],
        u = u_matrix[i, j],
        u_t = u_t,
        u_xx = u_xx,
        residual = residual,
        residual_squared = residual^2,
        notes = notes
      )

      row_index <- row_index + 1
    }
  }

  bind_rows(residual_rows)
}

residual_table <- pmap_dfr(
  list(
    cases$case_id,
    cases$diffusion,
    cases$n_x,
    cases$n_t,
    cases$notes
  ),
  run_case
)

summary_table <- residual_table %>%
  group_by(case_id) %>%
  summarise(
    mean_absolute_residual = mean(abs(residual)),
    root_mean_squared_residual = sqrt(mean(residual_squared)),
    max_absolute_residual = max(abs(residual)),
    .groups = "drop"
  )

write_csv(
  residual_table,
  file.path(article_dir, "data/computed_heat_residual_table_r.csv")
)

write_csv(
  summary_table,
  file.path(article_dir, "data/computed_heat_residual_summary_r.csv")
)

print(summary_table)
