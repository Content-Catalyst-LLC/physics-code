/*
Hubble and Enclosed Mass Table

This C workflow generates two simple astrophysical tables:

1. Low-redshift Hubble relation:
       v = H0 d

2. Enclosed mass from circular velocity:
       M = v^2 r / G
*/

#include <math.h>
#include <stdio.h>

const double G_SI = 6.67430e-11;
const double M_SUN_KG = 1.98847e30;
const double KPC_TO_M = 3.085677581491367e19;

double hubble_velocity(double h0_km_s_mpc, double distance_mpc) {
    return h0_km_s_mpc * distance_mpc;
}

double enclosed_mass_solar(double radius_kpc, double velocity_km_s) {
    double radius_m = radius_kpc * KPC_TO_M;
    double velocity_m_s = velocity_km_s * 1000.0;
    double mass_kg = velocity_m_s * velocity_m_s * radius_m / G_SI;
    return mass_kg / M_SUN_KG;
}

int main(void) {
    const double h0_km_s_mpc = 70.0;
    const double distances_mpc[] = {10.0, 50.0, 100.0, 500.0};
    const double radii_kpc[] = {5.0, 10.0, 20.0, 30.0};
    const double velocity_km_s = 220.0;

    printf("hubble_table\n");
    printf("distance_mpc,h0_km_s_mpc,recessional_velocity_km_s\n");

    for (int i = 0; i < 4; i++) {
        printf("%.3f,%.3f,%.3f\n",
               distances_mpc[i],
               h0_km_s_mpc,
               hubble_velocity(h0_km_s_mpc, distances_mpc[i]));
    }

    printf("\nenclosed_mass_table\n");
    printf("radius_kpc,velocity_km_s,enclosed_mass_solar\n");

    for (int i = 0; i < 4; i++) {
        printf("%.3f,%.3f,%.6e\n",
               radii_kpc[i],
               velocity_km_s,
               enclosed_mass_solar(radii_kpc[i], velocity_km_s));
    }

    return 0;
}
