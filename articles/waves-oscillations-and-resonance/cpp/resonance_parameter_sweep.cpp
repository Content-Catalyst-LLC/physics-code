/*
Resonance Parameter Sweep

This C++ workflow computes driven oscillator response amplitude:

    A(omega) = (F0/m) / sqrt((omega0^2 - omega^2)^2 + (2 gamma omega)^2)
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double response_amplitude(
    double mass_kg,
    double spring_constant,
    double damping,
    double driving_force,
    double omega
) {
    double omega0 = std::sqrt(spring_constant / mass_kg);
    double gamma = damping / (2.0 * mass_kg);

    double denominator = std::sqrt(
        std::pow(omega0 * omega0 - omega * omega, 2.0)
        + std::pow(2.0 * gamma * omega, 2.0)
    );

    return (driving_force / mass_kg) / denominator;
}

int main() {
    const double mass_kg = 1.0;
    const double spring_constant = 25.0;
    const double driving_force = 1.0;

    std::vector<double> damping_values = {0.2, 0.6, 1.2};

    std::cout << "damping_kg_per_s,omega_rad_per_s,response_amplitude_m\n";

    for (double damping : damping_values) {
        for (double omega = 0.1; omega <= 12.0001; omega += 0.1) {
            double amplitude = response_amplitude(
                mass_kg,
                spring_constant,
                damping,
                driving_force,
                omega
            );

            std::cout << std::setprecision(12)
                      << damping << ","
                      << omega << ","
                      << amplitude << "\n";
        }
    }

    return 0;
}
