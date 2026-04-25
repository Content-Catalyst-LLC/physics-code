/*
Hubble Parameter Sweep

This C++ workflow evaluates a simplified flat ΛCDM expansion function:

    H(z) = H0 * sqrt(Omega_m(1+z)^3 + Omega_r(1+z)^4 + Omega_lambda)

It is intended as performance-oriented scaffolding for parameter sweeps,
not as a production cosmology solver.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double hubble_parameter(double redshift) {
    const double h0 = 70.0;
    const double omega_m = 0.315;
    const double omega_r = 0.00009;
    const double omega_lambda = 0.685;

    const double zp1 = 1.0 + redshift;

    return h0 * std::sqrt(
        omega_m * std::pow(zp1, 3.0)
        + omega_r * std::pow(zp1, 4.0)
        + omega_lambda
    );
}

double scale_factor(double redshift) {
    return 1.0 / (1.0 + redshift);
}

int main() {
    std::vector<double> redshifts = {0.0, 0.5, 1.0, 2.0, 3.0, 10.0, 100.0, 1100.0};

    std::cout << "redshift,scale_factor,hubble_parameter_km_s_mpc\n";

    for (double z : redshifts) {
        std::cout << std::setprecision(10)
                  << z << ","
                  << scale_factor(z) << ","
                  << hubble_parameter(z) << "\n";
    }

    return 0;
}
