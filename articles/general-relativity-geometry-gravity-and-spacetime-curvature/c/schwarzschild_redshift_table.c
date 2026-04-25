/*
Schwarzschild Redshift Table

This C workflow computes Schwarzschild radius, compactness,
and gravitational redshift for Earth and Sun examples.
*/

#include <math.h>
#include <stdio.h>

double schwarzschild_radius(double mass_kg) {
    const double g = 6.67430e-11;
    const double c = 299792458.0;
    return 2.0 * g * mass_kg / (c * c);
}

double compactness(double mass_kg, double radius_m) {
    return schwarzschild_radius(mass_kg) / radius_m;
}

double redshift_z(double mass_kg, double radius_m) {
    double rs = schwarzschild_radius(mass_kg);

    if (radius_m <= rs) {
        return NAN;
    }

    return 1.0 / sqrt(1.0 - rs / radius_m) - 1.0;
}

int main(void) {
    double earth_mass = 5.9722e24;
    double earth_radius = 6.371e6;
    double solar_mass = 1.98847e30;
    double solar_radius = 6.957e8;

    printf("object,schwarzschild_radius_m,compactness,redshift_z\n");

    printf("earth,%.12e,%.12e,%.12e\n",
           schwarzschild_radius(earth_mass),
           compactness(earth_mass, earth_radius),
           redshift_z(earth_mass, earth_radius));

    printf("sun,%.12e,%.12e,%.12e\n",
           schwarzschild_radius(solar_mass),
           compactness(solar_mass, solar_radius),
           redshift_z(solar_mass, solar_radius));

    return 0;
}
