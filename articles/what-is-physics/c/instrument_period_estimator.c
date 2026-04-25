/*
Instrument Period Estimator

This C example represents a low-level instrumentation-style calculation.
In an embedded workflow, the measured time stamps might come from a sensor,
microcontroller timer, photogate, or other acquisition system.

Here, we estimate the mean period from repeated timing measurements.
*/

#include <math.h>
#include <stdio.h>

double mean_period(const double periods_s[], int n) {
    double total_s = 0.0;

    for (int i = 0; i < n; i++) {
        total_s += periods_s[i];
    }

    return total_s / n;
}

double sample_standard_deviation(const double values[], int n) {
    double mean = mean_period(values, n);
    double sum_squared_deviation = 0.0;

    for (int i = 0; i < n; i++) {
        double deviation = values[i] - mean;
        sum_squared_deviation += deviation * deviation;
    }

    return sqrt(sum_squared_deviation / (n - 1));
}

int main(void) {
    const double length_m = 1.00;
    const double gravity_m_per_s2 = 9.80665;
    const double observed_periods_s[] = {2.006, 2.010, 2.004};
    const int n = 3;

    double observed_mean_period_s = mean_period(observed_periods_s, n);
    double observed_sd_period_s = sample_standard_deviation(observed_periods_s, n);
    double predicted_period_s = 2.0 * M_PI * sqrt(length_m / gravity_m_per_s2);

    printf("length_m,observed_mean_period_s,observed_sd_period_s,predicted_period_s,residual_s\n");
    printf("%.3f,%.6f,%.6f,%.6f,%.6f\n",
           length_m,
           observed_mean_period_s,
           observed_sd_period_s,
           predicted_period_s,
           observed_mean_period_s - predicted_period_s);

    return 0;
}
