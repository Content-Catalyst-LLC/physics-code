/*
Pendulum Symplectic Euler Simulation

This C++ workflow demonstrates a performance-oriented numerical loop for
the small-angle pendulum.

Equation:
    theta'' = -(g / L) theta

First-order form:
    dtheta/dt = omega
    domega/dt = -(g / L) theta

The symplectic Euler method is often preferable to ordinary forward Euler
for simple mechanical systems because it tends to behave better for
long-running conservative dynamics.
*/

#include <cmath>
#include <iomanip>
#include <iostream>

int main() {
    const double gravity_m_per_s2 = 9.80665;
    const double length_m = 1.0;
    const double dt_s = 0.001;
    const double total_time_s = 10.0;

    double theta_rad = 0.10;
    double omega_rad_per_s = 0.0;

    const int steps = static_cast<int>(total_time_s / dt_s);

    std::cout << "time_s,theta_rad,omega_rad_per_s,energy_like_quantity\n";

    for (int step = 0; step <= steps; ++step) {
        const double time_s = step * dt_s;

        const double energy_like =
            0.5 * length_m * length_m * omega_rad_per_s * omega_rad_per_s
            + 0.5 * gravity_m_per_s2 * length_m * theta_rad * theta_rad;

        if (step % 100 == 0) {
            std::cout << std::fixed << std::setprecision(8)
                      << time_s << ","
                      << theta_rad << ","
                      << omega_rad_per_s << ","
                      << energy_like << "\n";
        }

        const double angular_acceleration_rad_per_s2 =
            -(gravity_m_per_s2 / length_m) * theta_rad;

        omega_rad_per_s += angular_acceleration_rad_per_s2 * dt_s;
        theta_rad += omega_rad_per_s * dt_s;
    }

    return 0;
}
