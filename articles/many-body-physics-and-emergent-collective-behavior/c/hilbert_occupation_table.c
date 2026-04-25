/*
Hilbert and Occupation Table

This C workflow computes spin-1/2 Hilbert-space dimensions
and sample Fermi/Bose occupation values.
*/

#include <math.h>
#include <stdint.h>
#include <stdio.h>

uint64_t integer_power_u64(uint64_t base, int exponent) {
    uint64_t result = 1;

    for (int i = 0; i < exponent; i++) {
        result *= base;
    }

    return result;
}

double fermi_occupation(double energy, double mu, double temperature, double k_b) {
    return 1.0 / (exp((energy - mu) / (k_b * temperature)) + 1.0);
}

double bose_occupation(double energy, double mu, double temperature, double k_b) {
    if (energy <= mu) {
        return NAN;
    }

    return 1.0 / (exp((energy - mu) / (k_b * temperature)) - 1.0);
}

int main(void) {
    double k_b_ev_k = 8.617333262e-5;

    printf("quantity,value\n");

    for (int n = 2; n <= 40; n += 2) {
        printf("spin_half_dimension_%d,%llu\n",
               n,
               (unsigned long long)integer_power_u64(2, n));
    }

    printf("fermi_E0_mu0_T300,%.12f\n",
           fermi_occupation(0.0, 0.0, 300.0, k_b_ev_k));

    printf("bose_E0p01_mu0_T300,%.12f\n",
           bose_occupation(0.01, 0.0, 300.0, k_b_ev_k));

    return 0;
}
