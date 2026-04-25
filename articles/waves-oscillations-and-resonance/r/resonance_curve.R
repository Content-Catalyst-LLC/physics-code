# Resonance Curve for a Driven Damped Oscillator
#
# This workflow computes the steady-state response amplitude:
#
#   A(omega) =
#     (F0/m) / sqrt((omega0^2 - omega^2)^2 + (2*gamma*omega)^2)

library(tidyverse)

article_dir <- "articles/waves-oscillations-and-resonance"

output_path <- file.path(article_dir, "data/computed_resonance_curve_r.csv")
summary_path <- file.path(article_dir, "data/computed_resonance_peak_summary_r.csv")

mass_kg <- 1.0
spring_constant_n_per_m <- 25.0
driving_force_n <- 1.0

natural_angular_frequency_rad_per_s <-
  sqrt(spring_constant_n_per_m / mass_kg)

resonance_table <- tibble(
  damping_coefficient_kg_per_s = c(0.2, 0.6, 1.2)
) %>%
  tidyr::crossing(
    driving_angular_frequency_rad_per_s =
      seq(0.1, 12.0, by = 0.05)
  ) %>%
  mutate(
    gamma_per_s = damping_coefficient_kg_per_s / (2 * mass_kg),
    response_amplitude_m =
      (driving_force_n / mass_kg) /
        sqrt(
          (natural_angular_frequency_rad_per_s^2 -
             driving_angular_frequency_rad_per_s^2)^2 +
            (2 * gamma_per_s *
               driving_angular_frequency_rad_per_s)^2
        ),
    frequency_ratio =
      driving_angular_frequency_rad_per_s /
      natural_angular_frequency_rad_per_s
  )

peak_summary <- resonance_table %>%
  group_by(damping_coefficient_kg_per_s) %>%
  slice_max(response_amplitude_m, n = 1, with_ties = FALSE) %>%
  ungroup() %>%
  select(
    damping_coefficient_kg_per_s,
    gamma_per_s,
    peak_driving_angular_frequency_rad_per_s =
      driving_angular_frequency_rad_per_s,
    frequency_ratio,
    peak_response_amplitude_m = response_amplitude_m
  )

write_csv(resonance_table, output_path)
write_csv(peak_summary, summary_path)

print(head(resonance_table, 12))
print(peak_summary)

cat("\nSaved resonance curve to:", output_path, "\n")
cat("Saved peak summary to:", summary_path, "\n")
