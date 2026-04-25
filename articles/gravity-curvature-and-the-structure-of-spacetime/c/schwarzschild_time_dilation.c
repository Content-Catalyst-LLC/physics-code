/*
Schwarzschild Time Dilation

This C workflow computes:

    r_s = 2GM/c^2
    d_tau/dt = sqrt(1 - r_s/r)

for a one-solar-mass Schwarzschild geometry.
*/

#include <math.h>
#include <stdio.h>

double schwarzschild_radius(double mass_kg) {
    const double G = 6.67430e-11;
    const double c = 299792458.0;

    return 2.0 * G * mass_kg / (c * c);
}

double clock_factor(double radius_m, double rs_m) {
    return sqrt(1.0 - rs_m / radius_m);
}

int main(void) {
    const double solar_mass_kg = 1.98847e30;
    double rs = schwarzschild_radius(solar_mass_kg);

    printf("radius_over_rs,radius_m,clock_factor\n");

    for (int i = 0; i <= 20; i++) {
        double radius_over_rs = 1.05 + 0.5 * i;
        double radius_m = radius_over_rs * rs;

        printf("%.6f,%.8e,%.8f\n",
               radius_over_rs,
               radius_m,
               clock_factor(radius_m, rs));
    }

    return 0;
}
