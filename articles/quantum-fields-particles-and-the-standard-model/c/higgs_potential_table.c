/*
Higgs-Like Potential Table

This C workflow evaluates a schematic one-dimensional potential:

    V(phi) = mu2 * phi^2 + lambda * phi^4

This is an educational scaffold, not the full Standard Model Higgs doublet.
*/

#include <math.h>
#include <stdio.h>

double higgs_like_potential(double phi, double mu2, double lambda) {
    return mu2 * phi * phi + lambda * pow(phi, 4.0);
}

int main(void) {
    const double mu2 = -1.0;
    const double lambda = 0.5;

    printf("phi,potential\n");

    for (int i = 0; i <= 60; i++) {
        double phi = -3.0 + 0.1 * i;
        double potential = higgs_like_potential(phi, mu2, lambda);

        printf("%.6f,%.8f\n", phi, potential);
    }

    return 0;
}
