# Redshift, Scale Factor, and Hubble Expansion
#
# This workflow demonstrates introductory cosmology relations:
#
#   v = H0 * d
#   a = 1 / (1 + z)
#
# It creates summary tables useful for teaching, article support,
# and reproducible documentation.

library(tidyverse)

h0_km_s_mpc <- 70

hubble_input <- "articles/cosmology-and-the-history-of-the-universe/data/hubble_reference_points.csv"
summary_output <- "articles/cosmology-and-the-history-of-the-universe/data/redshift_hubble_summary.csv"

hubble_table <- read_csv(hubble_input, show_col_types = FALSE) %>%
  mutate(
    recessional_velocity_km_s = h0_km_s_mpc * distance_mpc
  )

redshift_table <- tibble(
  redshift = c(0, 0.5, 1, 2, 3, 10, 100, 1100)
) %>%
  mutate(
    scale_factor = 1 / (1 + redshift),
    cmb_temperature_k = 2.7255 * (1 + redshift)
  )

summary_table <- tibble(
  maximum_distance_mpc = max(hubble_table$distance_mpc),
  maximum_recessional_velocity_km_s = max(hubble_table$recessional_velocity_km_s),
  minimum_scale_factor = min(redshift_table$scale_factor),
  maximum_redshift = max(redshift_table$redshift),
  maximum_cmb_temperature_k = max(redshift_table$cmb_temperature_k)
)

write_csv(summary_table, summary_output)

print(hubble_table)
print(redshift_table)
print(summary_table)
cat("\nSaved summary to:", summary_output, "\n")
