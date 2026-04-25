/*
Free-Fall Estimator

This C workflow models a low-level numerical calculation that could be
adapted for instrumentation or embedded measurement contexts.

Relation:
    s = 0.5 * g * t^2
*/

#include <math.h>
#include <stdio.h>

double free_fall_distance(double time_s, double gravity_m_per_s2) {
    return 0.5 * gravity_m_per_s2 * pow(time_s, 2.0);
}

int main(void) {
    const double gravity_m_per_s2 = 9.80665;

    printf("time_s,distance_m,gravity_m_per_s2\n");

    for (int i = 0; i <= 10; i++) {
        double time_s = (double)i;
        double distance_m = free_fall_distance(time_s, gravity_m_per_s2);

        printf("%.3f,%.6f,%.5f\n", time_s, distance_m, gravity_m_per_s2);
    }

    return 0;
}
