/*
Landau Scaling Table

This C workflow computes Landau free energy and simple critical scaling.
*/

#include <math.h>
#include <stdio.h>

double landau_free_energy(double m, double temperature, double critical_temperature, double a, double b) {
    return a * (temperature - critical_temperature) * m * m + b * pow(m, 4.0);
}

double order_parameter_scale(double reduced_temperature, double beta_exponent) {
    if (reduced_temperature >= 0.0) {
        return NAN;
    }

    return pow(fabs(reduced_temperature), beta_exponent);
}

double susceptibility_scale(double reduced_temperature, double gamma_exponent) {
    return pow(fabs(reduced_temperature), -gamma_exponent);
}

int main(void) {
    double reduced_temperatures[] = {-0.5, -0.25, -0.1, -0.05, 0.05, 0.1, 0.25, 0.5};
    int n_values = sizeof(reduced_temperatures) / sizeof(reduced_temperatures[0]);

    printf("section,parameter,value\n");

    printf("landau_free_energy,m0p5_T0p8,%.12f\n",
           landau_free_energy(0.5, 0.8, 1.0, 1.0, 1.0));

    for (int i = 0; i < n_values; i++) {
        double t = reduced_temperatures[i];

        printf("order_parameter_scale,t_%.3f,%.12f\n",
               t,
               order_parameter_scale(t, 0.5));

        printf("susceptibility_scale,t_%.3f,%.12f\n",
               t,
               susceptibility_scale(t, 1.0));
    }

    return 0;
}
