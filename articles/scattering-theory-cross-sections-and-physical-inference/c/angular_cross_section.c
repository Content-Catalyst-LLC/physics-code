/*
Angular Cross-Section Integration

Computes the analytic total cross section:

sigma_total = 4 pi sigma0 (1 + alpha/3)
*/

#include <math.h>
#include <stdio.h>

double total_cross_section(double sigma0, double alpha) {
    return 4.0 * M_PI * sigma0 * (1.0 + alpha / 3.0);
}

int main(void) {
    double sigma0 = 1.0;

    printf("sigma0,alpha,total_cross_section\n");

    for (double alpha = 0.0; alpha <= 2.0001; alpha += 0.5) {
        printf("%.6f,%.6f,%.12f\n", sigma0, alpha, total_cross_section(sigma0, alpha));
    }

    return 0;
}
