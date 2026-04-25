/*
Projectile Parameter Sweep

This C++ workflow computes ideal projectile time of flight, range, and
maximum height:

    T = 2 v0 sin(theta) / g
    R = v0^2 sin(2 theta) / g
    H = v0^2 sin^2(theta) / (2g)
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    const double pi = 3.14159265358979323846;
    const double g = 9.80665;

    std::vector<double> speeds = {8.0, 12.0, 18.0};
    std::vector<double> angles_deg = {20.0, 30.0, 45.0, 60.0, 70.0};

    std::cout << "initial_speed_m_per_s,launch_angle_deg,time_of_flight_s,range_m,max_height_m\n";

    for (double v0 : speeds) {
        for (double angle_deg : angles_deg) {
            double theta = angle_deg * pi / 180.0;
            double time_of_flight = 2.0 * v0 * std::sin(theta) / g;
            double range_m = v0 * v0 * std::sin(2.0 * theta) / g;
            double max_height = v0 * v0 * std::sin(theta) * std::sin(theta) / (2.0 * g);

            std::cout << std::setprecision(12)
                      << v0 << ","
                      << angle_deg << ","
                      << time_of_flight << ","
                      << range_m << ","
                      << max_height << "\n";
        }
    }

    return 0;
}
