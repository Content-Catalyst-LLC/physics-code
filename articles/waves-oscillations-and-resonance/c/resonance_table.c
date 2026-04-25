/*
Resonance Table

This C workflow computes the steady-state amplitude of a driven oscillator:

    A(omega) = (F0/m) / sqrt((omega0^2 - omega^2)^2 + (2 gamma omega)^2)
*/

#include <math.h>
#include <stdio.h>

double response_amplitude(
    double mass_kg,
    double spring_constant,
    double damping,
    double driving_force,
    double omega
) {
    double omega0 = sqrt(spring_constant / mass_kg);
    double gamma = damping / (2.0 * mass_kg);

    double denominator = sqrt(
        pow(omega0 * omega0 - omega * omega, 2.0)
        + pow(2.0 * gamma * omega, 2.0)
    );

    return (driving_force / mass_kg) / denominator;
}

int main(void) {
    const double mass_kg = 1.0;
    const double spring_constant = 25.0;
    const double driving_force = 1.0;

    double damping_values[] = {0.2, 0.6, 1.2};
    int damping_count = sizeof(damping_values) / sizeof(damping_values[0]);

    printf("damping_kg_per_s,omega_rad_per_s,response_amplitude_m\n");

    for (int i = 0; i < damping_count; i++) {
        double damping = damping_values[i];

        for (double omega = 0.1; omega <= 12.0001; omega += 0.1) {
            double amplitude = response_amplitude(
                mass_kg,
                spring_constant,
                damping,
                driving_force,
                omega
            );

            printf("%.8f,%.8f,%.12f\n", damping, omega, amplitude);
        }
    }

    return 0;
}
