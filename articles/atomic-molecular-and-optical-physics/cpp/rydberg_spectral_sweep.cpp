/*
Rydberg Spectral Sweep

This C++ workflow computes hydrogenic transition wavelengths with:

    1/lambda = R_H(1/n_lower^2 - 1/n_upper^2)
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

const double RYDBERG_HYDROGEN = 1.096775834e7;
const double HC_EV_NM = 1239.841984;

double wavelength_nm(int n_lower, int n_upper) {
    double inverse_wavelength_m =
        RYDBERG_HYDROGEN *
        (1.0 / (n_lower * n_lower) - 1.0 / (n_upper * n_upper));

    return (1.0 / inverse_wavelength_m) * 1.0e9;
}

double photon_energy_ev(double lambda_nm) {
    return HC_EV_NM / lambda_nm;
}

int main() {
    struct Series {
        std::string name;
        int n_lower;
    };

    std::vector<Series> series = {
        {"Lyman", 1},
        {"Balmer", 2},
        {"Paschen", 3}
    };

    std::cout << "series,n_lower,n_upper,wavelength_nm,photon_energy_ev\n";

    for (const auto& item : series) {
        for (int n_upper = item.n_lower + 1; n_upper <= item.n_lower + 7; ++n_upper) {
            double lambda = wavelength_nm(item.n_lower, n_upper);
            double energy = photon_energy_ev(lambda);

            std::cout << std::setprecision(12)
                      << item.name << ","
                      << item.n_lower << ","
                      << n_upper << ","
                      << lambda << ","
                      << energy << "\n";
        }
    }

    return 0;
}
