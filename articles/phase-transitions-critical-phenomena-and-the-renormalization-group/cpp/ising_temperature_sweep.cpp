/*
Ising Temperature Sweep Scaffold

This C++ workflow computes a mean-field-like magnetization approximation:

    m = tanh(Tc m / T)

using fixed-point iteration for educational scale comparison.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double solve_mean_field_magnetization(double temperature, double critical_temperature) {
    double m = 0.9;

    for (int iter = 0; iter < 10000; ++iter) {
        double next_m = std::tanh((critical_temperature / temperature) * m);

        if (std::abs(next_m - m) < 1.0e-12) {
            return next_m;
        }

        m = next_m;
    }

    return m;
}

int main() {
    const double critical_temperature = 1.0;

    std::cout << "temperature,mean_field_magnetization\n";

    for (double temperature = 0.5; temperature <= 1.5; temperature += 0.05) {
        double m = solve_mean_field_magnetization(temperature, critical_temperature);

        std::cout << std::setprecision(12)
                  << temperature << ","
                  << m << "\n";
    }

    return 0;
}
