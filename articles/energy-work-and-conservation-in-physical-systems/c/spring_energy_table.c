/*
Spring Energy Table

This C workflow computes:

    U = 1/2 k x^2
    v = x sqrt(k/m)

for a spring-launch model.
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double mass_kg = 0.50;
    const double spring_constant_n_per_m = 20.0;

    double compressions_m[] = {0.02, 0.04, 0.06, 0.08, 0.10, 0.12};
    int n = sizeof(compressions_m) / sizeof(compressions_m[0]);

    printf("mass_kg,spring_constant_n_per_m,compression_m,spring_energy_j,predicted_speed_m_per_s\n");

    for (int i = 0; i < n; i++) {
        double x = compressions_m[i];
        double spring_energy_j = 0.5 * spring_constant_n_per_m * x * x;
        double predicted_speed_m_per_s = x * sqrt(spring_constant_n_per_m / mass_kg);

        printf("%.6f,%.6f,%.6f,%.8f,%.8f\n",
               mass_kg,
               spring_constant_n_per_m,
               x,
               spring_energy_j,
               predicted_speed_m_per_s);
    }

    return 0;
}
