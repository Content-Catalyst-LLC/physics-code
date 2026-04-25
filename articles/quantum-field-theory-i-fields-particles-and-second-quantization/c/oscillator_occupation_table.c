/*
Oscillator Occupation Table

This C workflow computes harmonic oscillator energies and
Bose occupation values for dimensionless beta hbar omega.
*/

#include <math.h>
#include <stdio.h>

double oscillator_energy(double hbar, double omega, int n) {
    return hbar * omega * ((double)n + 0.5);
}

double bose_occupation(double x) {
    return 1.0 / (exp(x) - 1.0);
}

int main(void) {
    double x_values[] = {0.1, 0.5, 1.0, 2.0, 5.0, 10.0};
    int n_x = sizeof(x_values) / sizeof(x_values[0]);

    printf("section,parameter,value\n");

    for (int n = 0; n < 8; n++) {
        printf("oscillator_energy,n_%d,%.12f\n", n, oscillator_energy(1.0, 2.0, n));
    }

    for (int i = 0; i < n_x; i++) {
        printf("bose_occupation,x_%.2f,%.12e\n", x_values[i], bose_occupation(x_values[i]));
    }

    return 0;
}
