# Circular Orbits, Escape Speed, and Period Scaling
#
# This workflow computes:
#
#   v_circ = sqrt(mu / r)
#   v_esc  = sqrt(2 * mu / r)
#   T      = 2*pi*sqrt(r^3 / mu)

library(tidyverse)

article_dir <- "articles/gravitation-orbits-and-celestial-mechanics"

bodies_path <- file.path(article_dir, "data/central_bodies.csv")
cases_path <- file.path(article_dir, "data/orbital_cases.csv")
output_path <- file.path(article_dir, "data/computed_circular_orbit_scaling_r.csv")

bodies <- read_csv(bodies_path, show_col_types = FALSE)
cases <- read_csv(cases_path, show_col_types = FALSE)

orbit_table <- cases %>%
  left_join(
    bodies %>% select(body, mu_m3_per_s2, radius_m),
    by = c("central_body" = "body")
  ) %>%
  mutate(
    orbital_radius_m = radius_m + altitude_m,
    circular_speed_m_per_s =
      sqrt(mu_m3_per_s2 / orbital_radius_m),
    escape_speed_m_per_s =
      sqrt(2 * mu_m3_per_s2 / orbital_radius_m),
    orbital_period_s =
      2 * pi * sqrt(orbital_radius_m^3 / mu_m3_per_s2),
    orbital_period_hours =
      orbital_period_s / 3600,
    escape_to_circular_speed_ratio =
      escape_speed_m_per_s / circular_speed_m_per_s
  )

write_csv(orbit_table, output_path)

print(orbit_table)
cat("\nSaved circular orbit scaling table to:", output_path, "\n")
