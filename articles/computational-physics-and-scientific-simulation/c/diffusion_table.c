/*
Diffusion Table

This C workflow solves a one-dimensional diffusion equation using an
explicit finite-difference method.
*/

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    const double length_m = 1.0;
    const int n_grid = 201;
    const double diffusivity = 0.001;
    const double dt = 0.0002;
    const int n_steps = 1200;

    const double dx = length_m / (double)(n_grid - 1);
    const double s = diffusivity * dt / (dx * dx);

    if (s > 0.5) {
        fprintf(stderr, "Explicit diffusion stability condition violated.\n");
        return 1;
    }

    double *field = calloc(n_grid, sizeof(double));
    double *next_field = calloc(n_grid, sizeof(double));

    if (!field || !next_field) {
        fprintf(stderr, "Memory allocation failed.\n");
        return 1;
    }

    for (int i = 0; i < n_grid; i++) {
        double x = i * dx;
        field[i] = exp(-pow(x - 0.5, 2.0) / (2.0 * pow(0.04, 2.0)));
    }

    printf("step,time_s,total_integral,max_field,stability_number\n");

    for (int step = 0; step <= n_steps; step++) {
        if (step % 300 == 0) {
            double total = 0.0;
            double max_value = field[0];

            for (int i = 0; i < n_grid; i++) {
                total += field[i] * dx;
                if (field[i] > max_value) {
                    max_value = field[i];
                }
            }

            printf("%d,%.8f,%.12f,%.12f,%.8f\n",
                   step,
                   step * dt,
                   total,
                   max_value,
                   s);
        }

        for (int i = 0; i < n_grid; i++) {
            next_field[i] = field[i];
        }

        for (int i = 1; i < n_grid - 1; i++) {
            next_field[i] = field[i] + s * (field[i + 1] - 2.0 * field[i] + field[i - 1]);
        }

        next_field[0] = 0.0;
        next_field[n_grid - 1] = 0.0;

        double *temp = field;
        field = next_field;
        next_field = temp;
    }

    free(field);
    free(next_field);

    return 0;
}
