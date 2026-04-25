/*
Resistivity Temperature Table

This C workflow computes simplified metal-like and semiconductor-like
resistivity trends across temperature.

Metal:
    rho = rho0 * [1 + alpha * (T - 300)]

Semiconductor-like:
    rho = rho0 * exp(theta / T)
*/

#include <math.h>
#include <stdio.h>

double metal_resistivity(double temperature_k, double rho0, double alpha) {
    return rho0 * (1.0 + alpha * (temperature_k - 300.0));
}

double semiconductor_resistivity(double temperature_k, double rho0, double theta) {
    return rho0 * exp(theta / temperature_k);
}

int main(void) {
    const double metal_rho0 = 1.0e-8;
    const double alpha = 0.004;
    const double semiconductor_rho0 = 1.0e-3;
    const double theta = 2000.0;

    printf("temperature_k,metal_resistivity,semiconductor_resistivity\n");

    for (int i = 0; i <= 14; i++) {
        double temperature_k = 50.0 + 25.0 * i;

        printf("%.3f,%.8e,%.8e\n",
               temperature_k,
               metal_resistivity(temperature_k, metal_rho0, alpha),
               semiconductor_resistivity(temperature_k, semiconductor_rho0, theta));
    }

    return 0;
}
