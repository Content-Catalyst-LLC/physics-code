/*
Hydrogen Spectrum Table

This C workflow computes selected hydrogen spectral wavelengths and photon energies.
*/

#include <math.h>
#include <stdio.h>

double wavelength_nm(int n_lower, int n_upper) {
    const double rydberg_hydrogen = 1.096775834e7;
    double inverse_wavelength_m =
        rydberg_hydrogen *
        (1.0 / (n_lower * n_lower) - 1.0 / (n_upper * n_upper));

    return (1.0 / inverse_wavelength_m) * 1.0e9;
}

double photon_energy_ev(double lambda_nm) {
    const double hc_ev_nm = 1239.841984;
    return hc_ev_nm / lambda_nm;
}

int main(void) {
    printf("n_lower,n_upper,wavelength_nm,photon_energy_ev\n");

    for (int n_lower = 1; n_lower <= 3; n_lower++) {
        for (int n_upper = n_lower + 1; n_upper <= n_lower + 7; n_upper++) {
            double lambda = wavelength_nm(n_lower, n_upper);
            double energy = photon_energy_ev(lambda);

            printf("%d,%d,%.8f,%.8f\n", n_lower, n_upper, lambda, energy);
        }
    }

    return 0;
}
