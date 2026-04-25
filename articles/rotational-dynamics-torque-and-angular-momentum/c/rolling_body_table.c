/*
Rolling Body Table

This C workflow computes ideal rolling acceleration and final speed:

    a = g sin(theta) / (1 + beta)
    v = sqrt(2 g h / (1 + beta))
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double pi = 3.14159265358979323846;
    const double g = 9.80665;
    const double incline_angle_rad = 20.0 * pi / 180.0;
    const double height_drop_m = 1.0;

    const char *names[] = {
        "hoop",
        "solid_disk",
        "solid_sphere",
        "thin_spherical_shell",
        "sliding_point_mass"
    };

    double beta_values[] = {1.0, 0.5, 0.4, 2.0 / 3.0, 0.0};
    int n = sizeof(beta_values) / sizeof(beta_values[0]);

    printf("object,beta,acceleration_m_per_s2,final_speed_m_per_s,rotational_energy_fraction\n");

    for (int i = 0; i < n; i++) {
        double beta = beta_values[i];
        double acceleration = g * sin(incline_angle_rad) / (1.0 + beta);
        double final_speed = sqrt(2.0 * g * height_drop_m / (1.0 + beta));
        double rotational_energy_fraction = beta / (1.0 + beta);

        printf("%s,%.8f,%.8f,%.8f,%.8f\n",
               names[i],
               beta,
               acceleration,
               final_speed,
               rotational_energy_fraction);
    }

    return 0;
}
