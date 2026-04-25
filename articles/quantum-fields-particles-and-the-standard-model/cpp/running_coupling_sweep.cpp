/*
Running-Coupling Toy Model Sweep

This C++ workflow illustrates scale dependence using a schematic expression:

    g(mu) = g0 / [1 + beta * log(mu / mu0)]

This is not a precision renormalization-group equation. It is a compact
computational scaffold for the idea of scale-dependent effective couplings.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double running_coupling(double mu_gev, double g0, double beta, double mu0_gev = 91.1876) {
    return g0 / (1.0 + beta * std::log(mu_gev / mu0_gev));
}

int main() {
    std::vector<double> scales_gev = {1.0, 2.0, 5.0, 10.0, 91.1876, 100.0, 1000.0, 10000.0, 100000.0};

    std::cout << "mu_gev,strong_like_coupling,weak_like_coupling,hypercharge_like_coupling\n";

    for (double mu : scales_gev) {
        std::cout << std::setprecision(10)
                  << mu << ","
                  << running_coupling(mu, 1.2, 0.08) << ","
                  << running_coupling(mu, 0.65, 0.015) << ","
                  << running_coupling(mu, 0.36, -0.01) << "\n";
    }

    return 0;
}
