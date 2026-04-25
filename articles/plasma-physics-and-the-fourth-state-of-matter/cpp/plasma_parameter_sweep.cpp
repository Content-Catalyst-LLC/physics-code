/*
Plasma Parameter Sweep

This C++ workflow computes Debye length, plasma frequency,
cyclotron frequency, and Larmor radius.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    const double epsilon_0 = 8.8541878128e-12;
    const double e = 1.602176634e-19;
    const double me = 9.1093837015e-31;

    std::vector<double> densities = {1.0e14, 1.0e16, 1.0e18, 1.0e20};
    std::vector<double> temperatures_ev = {1.0, 10.0, 100.0};
    std::vector<double> magnetic_fields = {0.01, 0.1, 1.0};
    const double vperp = 1.0e5;

    std::cout << "density_m3,temperature_ev,B_t,debye_length_m,plasma_frequency_hz,cyclotron_frequency_hz,larmor_radius_m\n";

    for (double ne : densities) {
        for (double te_ev : temperatures_ev) {
            double te_j = te_ev * e;
            double lambda_d = std::sqrt(epsilon_0 * te_j / (ne * e * e));
            double omega_pe = std::sqrt(ne * e * e / (epsilon_0 * me));
            double fpe = omega_pe / (2.0 * M_PI);

            for (double B : magnetic_fields) {
                double omega_ce = e * B / me;
                double fce = omega_ce / (2.0 * M_PI);
                double r_l = me * vperp / (e * B);

                std::cout << std::setprecision(12)
                          << ne << ","
                          << te_ev << ","
                          << B << ","
                          << lambda_d << ","
                          << fpe << ","
                          << fce << ","
                          << r_l << "\n";
            }
        }
    }

    return 0;
}
