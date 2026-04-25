/*
Work-Energy Parameter Sweep

This C++ workflow computes spring potential energy and predicted launch speed:

    U = 1/2 k x^2
    v = x sqrt(k/m)

for selected masses, spring constants, and compressions.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    std::vector<double> masses_kg = {0.25, 0.50, 1.00};
    std::vector<double> spring_constants_n_per_m = {10.0, 20.0, 40.0};
    std::vector<double> compressions_m = {0.05, 0.10, 0.15};

    std::cout << "mass_kg,spring_constant_n_per_m,compression_m,spring_energy_j,predicted_speed_m_per_s\n";

    for (double mass_kg : masses_kg) {
        for (double k : spring_constants_n_per_m) {
            for (double x : compressions_m) {
                double spring_energy_j = 0.5 * k * x * x;
                double predicted_speed = x * std::sqrt(k / mass_kg);

                std::cout << std::setprecision(12)
                          << mass_kg << ","
                          << k << ","
                          << x << ","
                          << spring_energy_j << ","
                          << predicted_speed << "\n";
            }
        }
    }

    return 0;
}
