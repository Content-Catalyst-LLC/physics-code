/*
Electromagnetic Parameter Sweep

This C++ workflow computes:

    E(r) = q / (4*pi*epsilon0*r^2)
    V(r) = q / (4*pi*epsilon0*r)
    B(r) = mu0*I / (2*pi*r)

for selected radii.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    const double pi = 3.14159265358979323846;
    const double epsilon0 = 8.8541878188e-12;
    const double mu0 = 1.25663706127e-6;
    const double charge_c = 1.0e-9;
    const double current_a = 2.0;

    std::vector<double> radii_m = {0.02, 0.05, 0.10, 0.20, 0.40, 0.80, 1.00};

    std::cout << "radius_m,electric_field_n_per_c,electric_potential_v,wire_magnetic_field_t\n";

    for (double r : radii_m) {
        double electric_field = charge_c / (4.0 * pi * epsilon0 * r * r);
        double electric_potential = charge_c / (4.0 * pi * epsilon0 * r);
        double magnetic_field = mu0 * current_a / (2.0 * pi * r);

        std::cout << std::setprecision(12)
                  << r << ","
                  << electric_field << ","
                  << electric_potential << ","
                  << magnetic_field << "\n";
    }

    return 0;
}
