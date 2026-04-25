/*
Overdamped Langevin Trajectory

Simulates a simple overdamped Langevin process in a harmonic potential.

This is a compact C++ teaching scaffold.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <random>

int main() {
    const int n_steps = 10000;
    const double dt = 0.001;
    const double spring_constant = 2.0;
    const double mobility = 1.0;
    const double thermal_energy = 1.0;
    const double diffusion = mobility * thermal_energy;
    const double noise_scale = std::sqrt(2.0 * diffusion * dt);

    double x = 5.0;

    std::mt19937 rng(42);
    std::normal_distribution<double> normal(0.0, 1.0);

    std::cout << "step,time,position,force,potential_energy\n";

    for (int step = 0; step <= n_steps; ++step) {
        double time = step * dt;
        double force = -spring_constant * x;
        double potential_energy = 0.5 * spring_constant * x * x;

        if (step % 100 == 0) {
            std::cout << step << ","
                      << std::setprecision(10) << time << ","
                      << x << ","
                      << force << ","
                      << potential_energy << "\n";
        }

        x += mobility * force * dt + noise_scale * normal(rng);
    }

    return 0;
}
