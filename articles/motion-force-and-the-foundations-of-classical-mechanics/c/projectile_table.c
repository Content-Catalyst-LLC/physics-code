/*
Projectile Table

This C workflow computes ideal projectile time of flight, range, and
maximum height for selected launch angles.
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double pi = 3.14159265358979323846;
    const double g = 9.80665;
    const double v0 = 12.0;

    double angles_deg[] = {20.0, 30.0, 45.0, 60.0, 70.0};
    int n = sizeof(angles_deg) / sizeof(angles_deg[0]);

    printf("initial_speed_m_per_s,launch_angle_deg,time_of_flight_s,range_m,max_height_m\n");

    for (int i = 0; i < n; i++) {
        double theta = angles_deg[i] * pi / 180.0;
        double time_of_flight = 2.0 * v0 * sin(theta) / g;
        double range_m = v0 * v0 * sin(2.0 * theta) / g;
        double max_height = v0 * v0 * sin(theta) * sin(theta) / (2.0 * g);

        printf("%.6f,%.6f,%.8f,%.8f,%.8f\n",
               v0,
               angles_deg[i],
               time_of_flight,
               range_m,
               max_height);
    }

    return 0;
}
