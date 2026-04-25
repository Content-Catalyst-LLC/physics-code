/*
Logistic Map Table

This C workflow iterates:

    x_{n+1} = r x_n (1 - x_n)
*/

#include <stdio.h>

double logistic_step(double r, double x) {
    return r * x * (1.0 - x);
}

int main(void) {
    double r_values[] = {2.8, 3.2, 3.5, 3.9};
    int n_r = sizeof(r_values) / sizeof(r_values[0]);
    int n_iter = 60;

    printf("r,iteration,x\n");

    for (int i = 0; i < n_r; i++) {
        double r = r_values[i];
        double x = 0.2;

        for (int iteration = 1; iteration <= n_iter; iteration++) {
            printf("%.8f,%d,%.12f\n", r, iteration, x);
            x = logistic_step(r, x);
        }
    }

    return 0;
}
