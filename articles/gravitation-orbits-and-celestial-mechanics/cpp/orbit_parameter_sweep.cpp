/*
Orbit Parameter Sweep

This C++ workflow computes circular speed, escape speed, and orbital period:

    v_circ = sqrt(mu/r)
    v_esc = sqrt(2mu/r)
    T = 2*pi*sqrt(r^3/mu)
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    const double pi = 3.14159265358979323846;
    const double mu_earth = 3.986004418e14;
    const double earth_radius_m = 6.371e6;

    std::vector<double> altitudes_m = {
        400e3,
        700e3,
        20200e3,
        35786e3,
        60000e3
    };

    std::cout << "altitude_m,orbital_radius_m,circular_speed_m_per_s,escape_speed_m_per_s,period_hours\n";

    for (double altitude_m : altitudes_m) {
        double r = earth_radius_m + altitude_m;
        double v_circ = std::sqrt(mu_earth / r);
        double v_esc = std::sqrt(2.0 * mu_earth / r);
        double period_hours = 2.0 * pi * std::sqrt(r * r * r / mu_earth) / 3600.0;

        std::cout << std::setprecision(12)
                  << altitude_m << ","
                  << r << ","
                  << v_circ << ","
                  << v_esc << ","
                  << period_hours << "\n";
    }

    return 0;
}
