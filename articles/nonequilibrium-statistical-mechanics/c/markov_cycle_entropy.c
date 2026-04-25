/*
Markov Cycle Entropy Production

Computes current, affinity, and entropy production for a three-state cycle.
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    double k_plus_values[] = {1.0, 1.5, 3.0, 10.0, 1.0};
    double k_minus_values[] = {1.0, 1.0, 1.0, 1.0, 3.0};
    int n = sizeof(k_plus_values) / sizeof(k_plus_values[0]);

    printf("k_plus,k_minus,cycle_current,affinity_kb_units,entropy_production_kb_units\n");

    for (int i = 0; i < n; i++) {
        double k_plus = k_plus_values[i];
        double k_minus = k_minus_values[i];
        double current = (k_plus - k_minus) / 3.0;
        double affinity = 3.0 * log(k_plus / k_minus);
        double sdot = current * affinity;

        printf("%.6f,%.6f,%.12f,%.12f,%.12f\n",
               k_plus,
               k_minus,
               current,
               affinity,
               sdot);
    }

    return 0;
}
