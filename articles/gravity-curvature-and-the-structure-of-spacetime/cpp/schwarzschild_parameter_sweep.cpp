/*
Schwarzschild Parameter Sweep

This C++ workflow computes Schwarzschild radius and clock-rate factors:

    r_s = 2GM/c^2
    d_tau/dt = sqrt(1 - r_s/r)

for selected masses and radius multiples.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

const double G = 6.67430e-11;
const double C = 299792458.0;

double schwarzschild_radius(double mass_kg) {
    return 2.0 * G * mass_kg / (C * C);
}

double clock_factor(double radius_m, double rs_m) {
    return std::sqrt(1.0 - rs_m / radius_m);
}

int main() {
    std::vector<std::pair<std::string, double>> objects = {
        {"Earth", 5.972e24},
        {"Sun", 1.98847e30},
        {"Ten solar masses", 1.98847e31}
    };

    std::vector<double> radius_multiples = {1.05, 1.5, 2.0, 3.0, 5.0, 10.0, 20.0};

    std::cout << "object,mass_kg,schwarzschild_radius_m,radius_over_rs,clock_factor\n";

    for (const auto& object : objects) {
        double rs = schwarzschild_radius(object.second);

        for (double multiple : radius_multiples) {
            double radius = multiple * rs;

            std::cout << std::setprecision(12)
                      << object.first << ","
                      << object.second << ","
                      << rs << ","
                      << multiple << ","
                      << clock_factor(radius, rs) << "\n";
        }
    }

    return 0;
}
