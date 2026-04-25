/*
Rolling Parameter Sweep

This C++ workflow computes rolling acceleration and final speed:

    a = g sin(theta) / (1 + beta)
    v = sqrt(2 g h / (1 + beta))
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

struct Body {
    std::string name;
    double beta;
};

int main() {
    const double pi = 3.14159265358979323846;
    const double g = 9.80665;
    const double height_drop_m = 1.0;
    const double incline_angle_rad = 20.0 * pi / 180.0;

    std::vector<Body> bodies = {
        {"hoop", 1.0},
        {"solid_disk", 0.5},
        {"solid_sphere", 0.4},
        {"thin_spherical_shell", 2.0 / 3.0},
        {"sliding_point_mass", 0.0}
    };

    std::cout << "object,beta,acceleration_m_per_s2,final_speed_m_per_s,rotational_energy_fraction\n";

    for (const auto& body : bodies) {
        double acceleration = g * std::sin(incline_angle_rad) / (1.0 + body.beta);
        double final_speed = std::sqrt(2.0 * g * height_drop_m / (1.0 + body.beta));
        double rotational_energy_fraction = body.beta / (1.0 + body.beta);

        std::cout << std::setprecision(12)
                  << body.name << ","
                  << body.beta << ","
                  << acceleration << ","
                  << final_speed << ","
                  << rotational_energy_fraction << "\n";
    }

    return 0;
}
