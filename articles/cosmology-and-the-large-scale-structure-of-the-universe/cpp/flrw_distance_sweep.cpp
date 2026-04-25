/*
FLRW Distance Sweep

This C++ workflow computes E(z), H(z), and comoving distance
for a flat Lambda-CDM model using trapezoid integration.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double e_z(double z, double omega_m, double omega_lambda) {
    return std::sqrt(omega_m * std::pow(1.0 + z, 3.0) + omega_lambda);
}

double comoving_distance(double zmax, double h0, double omega_m, double omega_lambda) {
    if (zmax == 0.0) {
        return 0.0;
    }

    const double c_km_s = 299792.458;
    const int n_grid = 6000;
    const double dz = zmax / static_cast<double>(n_grid - 1);

    double total = 0.0;

    for (int i = 0; i < n_grid; ++i) {
        double z = dz * i;
        double weight = (i == 0 || i == n_grid - 1) ? 0.5 : 1.0;
        total += weight / e_z(z, omega_m, omega_lambda);
    }

    return (c_km_s / h0) * dz * total;
}

int main() {
    const double h0 = 67.4;
    const double omega_m = 0.315;
    const double omega_lambda = 0.685;

    std::vector<double> redshifts = {0.0, 0.1, 0.5, 1.0, 2.0, 3.0, 6.0};

    std::cout << "redshift,E_z,H_z_km_s_mpc,comoving_distance_mpc,luminosity_distance_mpc\n";

    for (double z : redshifts) {
        double ez = e_z(z, omega_m, omega_lambda);
        double chi = comoving_distance(z, h0, omega_m, omega_lambda);

        std::cout << std::setprecision(12)
                  << z << ","
                  << ez << ","
                  << h0 * ez << ","
                  << chi << ","
                  << chi * (1.0 + z) << "\n";
    }

    return 0;
}
