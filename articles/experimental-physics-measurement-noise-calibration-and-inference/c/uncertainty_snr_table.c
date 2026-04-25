/*
Uncertainty and SNR Table

This C workflow computes combined uncertainty, expanded uncertainty,
signal-to-noise ratio, and resistance uncertainty.
*/

#include <math.h>
#include <stdio.h>

double combined_uncertainty(const double *components, int n) {
    double sum_squares = 0.0;

    for (int i = 0; i < n; i++) {
        sum_squares += components[i] * components[i];
    }

    return sqrt(sum_squares);
}

double snr_db(double signal_rms, double noise_rms) {
    return 20.0 * log10(signal_rms / noise_rms);
}

double resistance_uncertainty(double voltage, double u_voltage, double current, double u_current) {
    double resistance = voltage / current;
    double relative = sqrt(pow(u_voltage / voltage, 2.0) + pow(u_current / current, 2.0));
    return resistance * relative;
}

int main(void) {
    double components[] = {0.02, 0.01, 0.005};
    int n_components = sizeof(components) / sizeof(components[0]);
    double uc = combined_uncertainty(components, n_components);

    printf("quantity,value\n");
    printf("combined_uncertainty,%.12f\n", uc);
    printf("expanded_uncertainty_k2,%.12f\n", 2.0 * uc);
    printf("snr_db,%.12f\n", snr_db(1.414213562, 0.25));
    printf("resistance_uncertainty_ohm,%.12f\n",
           resistance_uncertainty(10.0, 0.02, 2.0, 0.005));

    return 0;
}
