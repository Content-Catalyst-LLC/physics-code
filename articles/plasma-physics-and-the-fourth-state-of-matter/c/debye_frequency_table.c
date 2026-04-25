/*
Debye Length and Plasma Frequency Table

This C workflow computes:
    lambda_D = sqrt(epsilon_0 Te_J/(ne e^2))
    omega_pe = sqrt(ne e^2/(epsilon_0 me))
*/

#include <math.h>
#include <stdio.h>

double debye_length(double ne, double te_ev) {
    const double epsilon_0 = 8.8541878128e-12;
    const double e = 1.602176634e-19;
    double te_j = te_ev * e;
    return sqrt(epsilon_0 * te_j / (ne * e * e));
}

double plasma_frequency_hz(double ne) {
    const double epsilon_0 = 8.8541878128e-12;
    const double e = 1.602176634e-19;
    const double me = 9.1093837015e-31;
    double omega = sqrt(ne * e * e / (epsilon_0 * me));
    return omega / (2.0 * M_PI);
}

int main(void) {
    double densities[] = {1.0e14, 1.0e16, 1.0e18, 1.0e20};
    double temperatures[] = {1.0, 10.0, 100.0};

    int n_density = sizeof(densities) / sizeof(densities[0]);
    int n_temperature = sizeof(temperatures) / sizeof(temperatures[0]);

    printf("density_m3,temperature_ev,debye_length_m,plasma_frequency_hz\n");

    for (int i = 0; i < n_density; i++) {
        for (int j = 0; j < n_temperature; j++) {
            double ne = densities[i];
            double te = temperatures[j];

            printf("%.8e,%.4f,%.8e,%.8e\n",
                   ne,
                   te,
                   debye_length(ne, te),
                   plasma_frequency_hz(ne));
        }
    }

    return 0;
}
