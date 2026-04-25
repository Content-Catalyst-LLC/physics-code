/*
FLRW Table

This C workflow computes E(z), H(z), and scale factor for flat Lambda-CDM.
*/

#include <math.h>
#include <stdio.h>

double e_z(double z, double omega_m, double omega_lambda) {
    return sqrt(omega_m * pow(1.0 + z, 3.0) + omega_lambda);
}

int main(void) {
    const double h0 = 67.4;
    const double omega_m = 0.315;
    const double omega_lambda = 0.685;

    double redshifts[] = {0.0, 0.1, 0.5, 1.0, 2.0, 3.0, 6.0};
    int n = sizeof(redshifts) / sizeof(redshifts[0]);

    printf("redshift,scale_factor,E_z,H_z_km_s_mpc\n");

    for (int i = 0; i < n; i++) {
        double z = redshifts[i];
        double ez = e_z(z, omega_m, omega_lambda);

        printf("%.6f,%.12f,%.12f,%.12f\n",
               z,
               1.0 / (1.0 + z),
               ez,
               h0 * ez);
    }

    return 0;
}
