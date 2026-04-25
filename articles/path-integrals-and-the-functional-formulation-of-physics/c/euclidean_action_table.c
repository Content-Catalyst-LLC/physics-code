/*
Euclidean Action Table

This C workflow computes discretized Euclidean harmonic oscillator action
for sinusoidal paths.
*/

#include <math.h>
#include <stdio.h>

#define N_STEPS 128

double euclidean_action(const double path[], int n, double mass, double omega, double delta_tau) {
    double total = 0.0;

    for (int i = 0; i < n; i++) {
        int next = (i + 1) % n;

        double kinetic = mass / (2.0 * delta_tau) * pow(path[next] - path[i], 2.0);
        double potential = 0.5 * delta_tau * mass * omega * omega * path[i] * path[i];

        total += kinetic + potential;
    }

    return total;
}

int main(void) {
    const double beta = 4.0;
    const double delta_tau = beta / N_STEPS;
    const double mass = 1.0;
    const double omega = 1.0;

    double path[N_STEPS];

    printf("amplitude,euclidean_action,path_weight\n");

    for (double amplitude = 0.0; amplitude <= 2.0001; amplitude += 0.25) {
        for (int i = 0; i < N_STEPS; i++) {
            double tau = i * delta_tau;
            path[i] = amplitude * sin(2.0 * M_PI * tau / beta);
        }

        double action = euclidean_action(path, N_STEPS, mass, omega, delta_tau);

        printf("%.6f,%.12f,%.12f\n", amplitude, action, exp(-action));
    }

    return 0;
}
