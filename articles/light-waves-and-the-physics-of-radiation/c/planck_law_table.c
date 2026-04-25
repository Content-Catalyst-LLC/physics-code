/*
Planck Law Table

This C workflow computes Planck spectral radiance:

    B_lambda(T) = (2 h c^2 / lambda^5) / [exp(h c / (lambda k_B T)) - 1]

for selected wavelengths at T = 5800 K.
*/

#include <math.h>
#include <stdio.h>

double planck_lambda(double wavelength_m, double temperature_k) {
    const double h = 6.62607015e-34;
    const double c = 299792458.0;
    const double k_b = 1.380649e-23;

    double numerator = 2.0 * h * c * c;
    double exponent = h * c / (wavelength_m * k_b * temperature_k);
    double denominator = pow(wavelength_m, 5.0) * expm1(exponent);

    return numerator / denominator;
}

int main(void) {
    const double temperature_k = 5800.0;

    printf("wavelength_nm,temperature_k,spectral_radiance\n");

    for (int i = 0; i <= 30; i++) {
        double wavelength_nm = 100.0 + i * (2900.0 / 30.0);
        double wavelength_m = wavelength_nm * 1.0e-9;
        double radiance = planck_lambda(wavelength_m, temperature_k);

        printf("%.6f,%.6f,%.8e\n", wavelength_nm, temperature_k, radiance);
    }

    return 0;
}
