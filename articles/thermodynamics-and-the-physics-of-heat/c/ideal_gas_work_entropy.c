/*
Ideal Gas Work and Entropy

This C workflow computes reversible isothermal ideal-gas work:

    W = n R T ln(V2/V1)

and entropy change:

    Delta S = n R ln(V2/V1)
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double R = 8.314462618;
    const double n = 1.0;
    const double T = 300.0;
    const double V1 = 0.02;

    double final_volumes[] = {0.03, 0.04, 0.06, 0.08, 0.10};
    int count = sizeof(final_volumes) / sizeof(final_volumes[0]);

    printf("V1_m3,V2_m3,isothermal_work_j,entropy_change_j_per_k\n");

    for (int i = 0; i < count; i++) {
        double V2 = final_volumes[i];
        double work_j = n * R * T * log(V2 / V1);
        double entropy_change = n * R * log(V2 / V1);

        printf("%.6f,%.6f,%.8f,%.8f\n", V1, V2, work_j, entropy_change);
    }

    return 0;
}
