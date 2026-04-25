/*
Lorentz Factor Table

This C workflow computes:

    gamma = 1 / sqrt(1 - beta^2)

and scaled kinetic energy:

    K / (mc^2) = gamma - 1
*/

#include <math.h>
#include <stdio.h>

double lorentz_factor(double beta) {
    return 1.0 / sqrt(1.0 - beta * beta);
}

int main(void) {
    double betas[] = {0.0, 0.1, 0.3, 0.5, 0.8, 0.9, 0.99};
    int n = sizeof(betas) / sizeof(betas[0]);

    printf("beta,gamma,relativistic_ke_scaled,newtonian_ke_scaled\n");

    for (int i = 0; i < n; i++) {
        double beta = betas[i];
        double gamma = lorentz_factor(beta);
        double relativistic_ke_scaled = gamma - 1.0;
        double newtonian_ke_scaled = 0.5 * beta * beta;

        printf("%.6f,%.8f,%.8f,%.8f\n",
               beta,
               gamma,
               relativistic_ke_scaled,
               newtonian_ke_scaled);
    }

    return 0;
}
