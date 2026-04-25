/*
Particle-in-a-Box Energy Table

This C workflow computes:

    E_n = n^2*pi^2*hbar^2 / (2*m*L^2)

for an electron in a one-dimensional infinite square well.
*/

#include <math.h>
#include <stdio.h>

double particle_box_energy_j(int n, double hbar_j_s, double mass_kg, double box_length_m) {
    return (n * n * M_PI * M_PI * hbar_j_s * hbar_j_s)
           / (2.0 * mass_kg * box_length_m * box_length_m);
}

int main(void) {
    const double hbar_j_s = 1.054571817e-34;
    const double electron_mass_kg = 9.1093837015e-31;
    const double joule_per_ev = 1.602176634e-19;
    const double box_length_m = 1.0e-9;

    printf("n,energy_j,energy_ev\n");

    for (int n = 1; n <= 10; n++) {
        double energy_j = particle_box_energy_j(n, hbar_j_s, electron_mass_kg, box_length_m);
        printf("%d,%.12e,%.8f\n", n, energy_j, energy_j / joule_per_ev);
    }

    return 0;
}
