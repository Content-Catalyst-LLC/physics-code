/*
Transport Parameter Sweep

This C++ workflow computes simplified metal-like and semiconductor-like
resistivity curves across temperature.

Metal:
    rho = rho0 * [1 + alpha * (T - 300)]

Semiconductor-like activated trend:
    rho = rho0 * exp(theta / T)
*/

#include <cmath>
#include <iomanip>
#include <iostream>

double metal_resistivity(double temperature_k, double rho0, double alpha) {
    return rho0 * (1.0 + alpha * (temperature_k - 300.0));
}

double semiconductor_resistivity(double temperature_k, double rho0, double theta) {
    return rho0 * std::exp(theta / temperature_k);
}

int main() {
    const double metal_rho0 = 1.0e-8;
    const double alpha = 0.004;
    const double semiconductor_rho0 = 1.0e-3;
    const double theta = 2000.0;

    std::cout << "temperature_k,metal_resistivity,semiconductor_resistivity\n";

    for (double temperature_k = 50.0; temperature_k <= 400.0; temperature_k += 25.0) {
        std::cout << std::setprecision(10)
                  << temperature_k << ","
                  << metal_resistivity(temperature_k, metal_rho0, alpha) << ","
                  << semiconductor_resistivity(temperature_k, semiconductor_rho0, theta) << "\n";
    }

    return 0;
}
