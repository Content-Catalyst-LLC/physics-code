# FLRW Expansion and Distance-Redshift Table
#
# This workflow computes E(z), H(z), comoving distance,
# angular diameter distance, and luminosity distance for flat Lambda-CDM.

library(tidyverse)

article_dir <- "articles/cosmology-and-the-large-scale-structure-of-the-universe"

params <- read_csv(file.path(article_dir, "data/cosmology_parameters.csv"), show_col_types = FALSE)

get_param <- function(name) {
  params %>% filter(parameter == name) %>% pull(value)
}

speed_of_light_km_s <- get_param("c")
hubble_constant <- get_param("H0")
omega_matter <- get_param("Omega_m")
omega_lambda <- get_param("Omega_lambda")

e_z <- function(z) {
  sqrt(omega_matter * (1 + z)^3 + omega_lambda)
}

h_z <- function(z) {
  hubble_constant * e_z(z)
}

comoving_distance_mpc <- function(z_max, n_grid = 5000) {
  if (z_max == 0) {
    return(0)
  }

  z_grid <- seq(0, z_max, length.out = n_grid)
  integrand <- 1 / e_z(z_grid)

  dz <- z_grid[2] - z_grid[1]

  integral <- dz * (
    0.5 * first(integrand) +
      sum(integrand[2:(length(integrand) - 1)]) +
      0.5 * last(integrand)
  )

  (speed_of_light_km_s / hubble_constant) * integral
}

redshift_table <- read_csv(file.path(article_dir, "data/redshift_grid.csv"), show_col_types = FALSE) %>%
  rowwise() %>%
  mutate(
    scale_factor = 1 / (1 + redshift),
    expansion_e_z = e_z(redshift),
    hubble_parameter_km_s_mpc = h_z(redshift),
    comoving_distance_mpc = comoving_distance_mpc(redshift),
    angular_diameter_distance_mpc = comoving_distance_mpc / (1 + redshift),
    luminosity_distance_mpc = comoving_distance_mpc * (1 + redshift)
  ) %>%
  ungroup()

output_path <- file.path(article_dir, "data/computed_flrw_expansion_distances_r.csv")
write_csv(redshift_table, output_path)

print(redshift_table)
cat("\nSaved FLRW expansion and distance table to:", output_path, "\n")
