/*
Bohr Energy Table

This C workflow computes:

    E_n = -13.6 / n^2

for introductory hydrogen-like atomic levels.
*/

#include <stdio.h>

double bohr_energy_ev(int n) {
    return -13.6 / (double)(n * n);
}

int main(void) {
    printf("n,energy_ev\n");

    for (int n = 1; n <= 12; n++) {
        printf("%d,%.8f\n", n, bohr_energy_ev(n));
    }

    return 0;
}
