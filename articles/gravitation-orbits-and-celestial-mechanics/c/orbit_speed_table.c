/*
Orbit Speed Table

This C workflow computes circular speed, escape speed, and orbital period:

    v_circ = sqrt(mu/r)
    v_esc  = sqrt(2mu/r)
    T      = 2*pi*sqrt(r^3/mu)
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double pi = 3.14159265358979323846;
    const double mu_earth = 3.986004418e14;
    const double earth_radius_m = 6.371e6;

    double altitudes_m[] = {400e3, 700e3, 20200e3, 35786e3, 60000e3};
    int n = sizeof(altitudes_m) / sizeof(altitudes_m[0]);

    printf("altitude_m,orbital_radius_m,circular_speed_m_per_s,escape_speed_m_per_s,period_hours\n");

    for (int i = 0; i < n; i++) {
        double r = earth_radius_m + altitudes_m[i];
        double circular_speed = sqrt(mu_earth / r);
        double escape_speed = sqrt(2.0 * mu_earth / r);
        double period_hours = 2.0 * pi * sqrt((r * r * r) / mu_earth) / 3600.0;

        printf("%.3f,%.3f,%.8f,%.8f,%.8f\n",
               altitudes_m[i],
               r,
               circular_speed,
               escape_speed,
               period_hours);
    }

    return 0;
}
