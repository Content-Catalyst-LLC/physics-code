/*
Pendulum Measurement Table

This C workflow computes:

    T = 2*pi*sqrt(L/g)
    g = 4*pi^2*L/T^2
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double pi = 3.14159265358979323846;
    const double gravity = 9.80665;

    double lengths_m[] = {0.25, 0.50, 0.75, 1.00, 1.50};
    int n = sizeof(lengths_m) / sizeof(lengths_m[0]);

    printf("length_m,small_angle_period_s,g_estimate_from_period_m_per_s2\n");

    for (int i = 0; i < n; i++) {
        double length_m = lengths_m[i];
        double period_s = 2.0 * pi * sqrt(length_m / gravity);
        double g_estimate = 4.0 * pi * pi * length_m / (period_s * period_s);

        printf("%.6f,%.8f,%.8f\n", length_m, period_s, g_estimate);
    }

    return 0;
}
