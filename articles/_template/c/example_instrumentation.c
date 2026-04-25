#include <stdio.h>

double kinetic_energy(double mass_kg, double velocity_m_per_s) {
    return 0.5 * mass_kg * velocity_m_per_s * velocity_m_per_s;
}

int main(void) {
    double mass_kg = 2.0;
    double velocity_m_per_s = 4.0;

    printf("KE = %.3f J\n", kinetic_energy(mass_kg, velocity_m_per_s));
    return 0;
}
