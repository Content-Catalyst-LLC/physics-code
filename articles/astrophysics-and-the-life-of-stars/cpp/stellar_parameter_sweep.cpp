/*
Stellar Parameter Sweep

This C++ workflow computes simple main-sequence scaling values:

    L = M^3.5
    t = M / L

where:
    M = stellar mass in solar units
    L = luminosity in solar units
    t = lifetime relative to the Sun

The workflow is educational scaffolding, not a full stellar-evolution model.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double luminosity_from_mass(double mass_solar) {
    return std::pow(mass_solar, 3.5);
}

double lifetime_relative(double mass_solar, double luminosity_solar) {
    return mass_solar / luminosity_solar;
}

int main() {
    std::vector<double> masses_solar = {0.2, 0.5, 1.0, 2.0, 5.0, 10.0, 20.0, 40.0};

    std::cout << "mass_solar,luminosity_solar_scaling,lifetime_relative_to_sun\n";

    for (double mass_solar : masses_solar) {
        double luminosity = luminosity_from_mass(mass_solar);
        double lifetime = lifetime_relative(mass_solar, luminosity);

        std::cout << std::setprecision(10)
                  << mass_solar << ","
                  << luminosity << ","
                  << lifetime << "\n";
    }

    return 0;
}
