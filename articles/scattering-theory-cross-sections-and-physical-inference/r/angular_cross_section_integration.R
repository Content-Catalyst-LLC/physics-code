# Angular Cross-Section Integration
#
# Computes:
#
#   sigma_total = 2 pi integral_0^pi (d sigma / d Omega)(theta) sin(theta) d theta
#
# for:
#
#   d sigma / d Omega = sigma_0 * (1 + alpha cos^2(theta))

library(tidyverse)

article_dir <- "articles/scattering-theory-cross-sections-and-physical-inference"

cases <- read_csv(
  file.path(article_dir, "data/angular_distribution_cases.csv"),
  show_col_types = FALSE
)

compute_total_cross_section <- function(sigma_0, alpha, n_grid) {
  theta <- seq(0, pi, length.out = n_grid)

  differential_cross_section <- sigma_0 * (1 + alpha * cos(theta)^2)
  integrand <- differential_cross_section * sin(theta)

  delta_theta <- theta[2] - theta[1]

  numerical_integral <- delta_theta * (
    0.5 * first(integrand) +
      sum(integrand[2:(length(integrand) - 1)]) +
      0.5 * last(integrand)
  )

  sigma_total_numeric <- 2 * pi * numerical_integral
  sigma_total_analytic <- 4 * pi * sigma_0 * (1 + alpha / 3)

  tibble(
    sigma_total_numeric = sigma_total_numeric,
    sigma_total_analytic = sigma_total_analytic,
    absolute_error = abs(sigma_total_numeric - sigma_total_analytic),
    relative_error = absolute_error / sigma_total_analytic
  )
}

summary <- cases %>%
  mutate(result = pmap(list(sigma_0, alpha, n_grid), compute_total_cross_section)) %>%
  select(case_id, sigma_0, alpha, n_grid, notes, result) %>%
  unnest(result)

write_csv(
  summary,
  file.path(article_dir, "data/computed_angular_cross_section_integration_r.csv")
)

print(summary)
