/*
Stress-Strain Table

This C workflow computes:

    sigma = E epsilon
    w = 1/2 sigma epsilon
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double youngs_modulus_pa = 200.0e9;

    double strain_values[] = {0.0, 0.0005, 0.0010, 0.0015, 0.0020, 0.0025};
    int n = sizeof(strain_values) / sizeof(strain_values[0]);

    printf("strain,stress_mpa,elastic_energy_density_j_per_m3\n");

    for (int i = 0; i < n; i++) {
        double strain = strain_values[i];
        double stress_pa = youngs_modulus_pa * strain;
        double energy_density = 0.5 * stress_pa * strain;

        printf("%.8f,%.8f,%.8f\n", strain, stress_pa / 1.0e6, energy_density);
    }

    return 0;
}
