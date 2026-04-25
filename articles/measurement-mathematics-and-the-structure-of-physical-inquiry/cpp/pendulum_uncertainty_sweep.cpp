/*
Pendulum Uncertainty Sweep

This C++ workflow computes:

    g = 4*pi^2*L / T^2

for selected pendulum lengths and periods.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double estimate_gravity(double length_m, double period_s) {
    const double pi = 3.14159265358979323846;
    return 4.0 * pi * pi * length_m / (period_s * period_s);
}

int main() {
    std::vector<double> lengths_m = {0.50, 0.75, 1.00};
    std::vector<double> periods_s = {1.42, 1.74, 2.01};

    std::cout << "length_m,period_s,g_estimate_m_per_s2\n";

    for (double length_m : lengths_m) {
        for (double period_s : periods_s) {
            std::cout << std::setprecision(12)
                      << length_m << ","
                      << period_s << ","
                      << estimate_gravity(length_m, period_s) << "\n";
        }
    }

    return 0;
}
