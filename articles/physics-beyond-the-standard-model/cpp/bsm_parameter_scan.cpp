/*
BSM Parameter Scan

This C++ workflow performs a simplified parameter scan over mass and coupling.

Toy model:
    prediction = coupling^2 / sqrt(mass_gev)

This is not a physical constraint calculation. It demonstrates a
performance-oriented loop pattern for model scanning.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double toy_prediction(double mass_gev, double coupling) {
    return (coupling * coupling) / std::sqrt(mass_gev);
}

int main() {
    std::vector<double> masses_gev = {1.0, 10.0, 100.0, 1000.0, 10000.0};
    std::vector<double> couplings = {1e-4, 1e-3, 1e-2, 5e-2, 1e-1};
    const double toy_limit = 1e-5;

    std::cout << "mass_gev,coupling,toy_prediction,toy_limit,excluded\n";

    for (double mass_gev : masses_gev) {
        for (double coupling : couplings) {
            double prediction = toy_prediction(mass_gev, coupling);
            bool excluded = prediction > toy_limit;

            std::cout << std::setprecision(10)
                      << mass_gev << ","
                      << coupling << ","
                      << prediction << ","
                      << toy_limit << ","
                      << excluded << "\n";
        }
    }

    return 0;
}
