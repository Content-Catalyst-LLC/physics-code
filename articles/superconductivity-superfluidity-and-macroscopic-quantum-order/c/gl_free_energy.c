/*
Ginzburg-Landau Free Energy

Computes equilibrium amplitude for alpha(T) = alpha0 (T - Tc).
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double tc = 9.2;
    const double alpha0 = 1.0;
    const double beta = 1.0;

    printf("temperature_k,alpha,equilibrium_amplitude\n");

    for (double temperature = 2.0; temperature <= 14.0001; temperature += 0.5) {
        double alpha = alpha0 * (temperature - tc);
        double amplitude = alpha < 0.0 ? sqrt(-alpha / beta) : 0.0;

        printf("%.6f,%.12f,%.12f\n", temperature, alpha, amplitude);
    }

    return 0;
}
