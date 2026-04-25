/*
Harmonic Energy Check

This C workflow computes ideal harmonic oscillator energy:

    E = 0.5*m*v^2 + 0.5*k*x^2

The ideal total energy is constant.
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double mass = 1.0;
    const double spring_constant = 4.0;
    const double amplitude = 1.0;
    const double omega = sqrt(spring_constant / mass);

    printf("time,position,velocity,kinetic_energy,potential_energy,total_energy\n");

    for (int i = 0; i <= 20; i++) {
        double time = 0.5 * i;
        double position = amplitude * cos(omega * time);
        double velocity = -amplitude * omega * sin(omega * time);

        double kinetic_energy = 0.5 * mass * velocity * velocity;
        double potential_energy = 0.5 * spring_constant * position * position;
        double total_energy = kinetic_energy + potential_energy;

        printf("%.6f,%.8f,%.8f,%.8f,%.8f,%.8f\n",
               time,
               position,
               velocity,
               kinetic_energy,
               potential_energy,
               total_energy);
    }

    return 0;
}
