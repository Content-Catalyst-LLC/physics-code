/*
Pendulum Uncertainty

This C workflow computes:

    g = 4*pi^2*L / T^2

and first-order propagated uncertainty for length and period inputs.
*/

#include <math.h>
#include <stdio.h>

double estimate_g(double length_m, double period_s) {
    return 4.0 * M_PI * M_PI * length_m / (period_s * period_s);
}

double propagated_uncertainty(double length_m, double u_length_m, double period_s, double u_period_s) {
    double dg_dlength = 4.0 * M_PI * M_PI / (period_s * period_s);
    double dg_dperiod = -8.0 * M_PI * M_PI * length_m / (period_s * period_s * period_s);

    return sqrt(
        pow(dg_dlength * u_length_m, 2.0)
        + pow(dg_dperiod * u_period_s, 2.0)
    );
}

int main(void) {
    double length_m = 0.75;
    double u_length_m = 0.001;
    double period_s = 1.741;
    double u_period_s = 0.005;

    double g = estimate_g(length_m, period_s);
    double u_g = propagated_uncertainty(length_m, u_length_m, period_s, u_period_s);

    printf("length_m,u_length_m,period_s,u_period_s,g_estimate_m_s2,u_g_m_s2\n");
    printf("%.6f,%.6f,%.6f,%.6f,%.8f,%.8f\n",
           length_m,
           u_length_m,
           period_s,
           u_period_s,
           g,
           u_g);

    return 0;
}
