/*
Oscillator Table

This C workflow computes harmonic oscillator energy:

    E = 1/2 m v^2 + 1/2 k x^2
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double mass_kg = 1.0;
    const double spring_constant = 25.0;

    double x_values[] = {-1.0, -0.5, 0.0, 0.5, 1.0};
    double v_values[] = {-2.0, -1.0, 0.0, 1.0, 2.0};

    int nx = sizeof(x_values) / sizeof(x_values[0]);
    int nv = sizeof(v_values) / sizeof(v_values[0]);

    printf("displacement_m,velocity_m_per_s,total_energy_j\n");

    for (int i = 0; i < nx; i++) {
        for (int j = 0; j < nv; j++) {
            double x = x_values[i];
            double v = v_values[j];
            double energy = 0.5 * mass_kg * v * v + 0.5 * spring_constant * x * x;

            printf("%.8f,%.8f,%.8f\n", x, v, energy);
        }
    }

    return 0;
}
