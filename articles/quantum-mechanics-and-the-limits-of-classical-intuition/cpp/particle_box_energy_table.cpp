/*
Particle-in-a-Box Energy Table

This C++ workflow computes:

    E_n = n^2*pi^2*hbar^2 / (2*m*L^2)

for the first several quantum states of an electron in a one-dimensional
infinite square well.
*/

#include <cmath>
#include <iomanip>
#include <iostream>

int main() {
    const double pi = 3.14159265358979323846;
    const double hbar_j_s = 1.054571817e-34;
    const double electron_mass_kg = 9.1093837015e-31;
    const double joule_per_ev = 1.602176634e-19;
    const double box_length_m = 1.0e-9;

    std::cout << "n,energy_j,energy_ev\n";

    for (int n = 1; n <= 10; ++n) {
        double energy_j = (n * n * pi * pi * hbar_j_s * hbar_j_s)
                        / (2.0 * electron_mass_kg * box_length_m * box_length_m);

        std::cout << std::setprecision(12)
                  << n << ","
                  << energy_j << ","
                  << energy_j / joule_per_ev << "\n";
    }

    return 0;
}
