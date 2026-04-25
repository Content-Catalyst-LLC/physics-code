/*
Hubble Velocity Table

This C workflow generates a simple low-redshift Hubble relation table:

    v = H0 * d

where:
    v = recessional velocity in km/s
    H0 = Hubble constant in km/s/Mpc
    d = distance in Mpc
*/

#include <stdio.h>

double hubble_velocity(double h0_km_s_mpc, double distance_mpc) {
    return h0_km_s_mpc * distance_mpc;
}

int main(void) {
    const double h0_km_s_mpc = 70.0;
    const double distances_mpc[] = {10.0, 50.0, 100.0, 250.0, 500.0};
    const int n_distances = 5;

    printf("distance_mpc,h0_km_s_mpc,recessional_velocity_km_s\n");

    for (int i = 0; i < n_distances; i++) {
        double velocity = hubble_velocity(h0_km_s_mpc, distances_mpc[i]);
        printf("%.3f,%.3f,%.3f\n", distances_mpc[i], h0_km_s_mpc, velocity);
    }

    return 0;
}
