/*
Coulomb Field Table

This C workflow computes:

    E(r) = q / (4*pi*epsilon0*r^2)
    V(r) = q / (4*pi*epsilon0*r)

for a point charge.
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double pi = 3.14159265358979323846;
    const double epsilon0 = 8.8541878188e-12;
    const double charge_c = 1.0e-9;

    double radii_m[] = {0.02, 0.05, 0.10, 0.20, 0.40, 0.80, 1.00};
    int n = sizeof(radii_m) / sizeof(radii_m[0]);

    printf("radius_m,electric_field_n_per_c,electric_potential_v\n");

    for (int i = 0; i < n; i++) {
        double r = radii_m[i];
        double electric_field = charge_c / (4.0 * pi * epsilon0 * r * r);
        double electric_potential = charge_c / (4.0 * pi * epsilon0 * r);

        printf("%.6f,%.8e,%.8e\n", r, electric_field, electric_potential);
    }

    return 0;
}
