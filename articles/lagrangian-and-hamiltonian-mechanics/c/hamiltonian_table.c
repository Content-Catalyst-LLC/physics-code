/*
Hamiltonian Table

This C workflow computes the simple pendulum Hamiltonian:

    H = p^2/(2 m l^2) + m g l(1 - cos(theta))
*/

#include <math.h>
#include <stdio.h>

double hamiltonian(double theta, double p, double mass, double length, double g) {
    return p * p / (2.0 * mass * length * length)
        + mass * g * length * (1.0 - cos(theta));
}

int main(void) {
    const double pi = 3.14159265358979323846;
    const double mass = 1.0;
    const double length = 1.0;
    const double g = 9.80665;

    double theta_values[] = {-pi, -pi / 2.0, 0.0, pi / 2.0, pi};
    double p_values[] = {-4.0, -2.0, 0.0, 2.0, 4.0};

    int n_theta = sizeof(theta_values) / sizeof(theta_values[0]);
    int n_p = sizeof(p_values) / sizeof(p_values[0]);

    printf("theta_rad,p_theta_kg_m2_per_s,hamiltonian_j\n");

    for (int i = 0; i < n_theta; i++) {
        for (int j = 0; j < n_p; j++) {
            printf(
                "%.8f,%.8f,%.8f\n",
                theta_values[i],
                p_values[j],
                hamiltonian(theta_values[i], p_values[j], mass, length, g)
            );
        }
    }

    return 0;
}
