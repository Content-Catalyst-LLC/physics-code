/*
Stellar Scaling Table

This C workflow computes simple main-sequence scaling values:

    L = M^3.5
    t = M / L

It is a low-level educational example, not a calibrated stellar model.
*/

#include <math.h>
#include <stdio.h>

double luminosity_from_mass(double mass_solar) {
    return pow(mass_solar, 3.5);
}

double lifetime_relative(double mass_solar, double luminosity_solar) {
    return mass_solar / luminosity_solar;
}

int main(void) {
    const double masses_solar[] = {0.2, 0.5, 1.0, 2.0, 5.0, 10.0, 20.0, 40.0};
    const int n_masses = 8;

    printf("mass_solar,luminosity_solar_scaling,lifetime_relative_to_sun\n");

    for (int i = 0; i < n_masses; i++) {
        double mass = masses_solar[i];
        double luminosity = luminosity_from_mass(mass);
        double lifetime = lifetime_relative(mass, luminosity);

        printf("%.6f,%.6e,%.6e\n", mass, luminosity, lifetime);
    }

    return 0;
}
