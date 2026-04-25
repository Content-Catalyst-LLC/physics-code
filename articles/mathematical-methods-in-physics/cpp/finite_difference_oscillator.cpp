/*
Finite Difference Oscillator

This C++ workflow advances a harmonic oscillator using a simple
semi-implicit update.
*/

#include <cmath>
#include <iomanip>
#include <iostream>

int main() {
    const double mass_kg = 1.0;
    const double spring_constant = 25.0;
    const double omega0_squared = spring_constant / mass_kg;
    const double dt = 0.01;
    const int n_steps = 1000;

    double x = 1.0;
    double v = 0.0;

    std::cout << "step,time_s,displacement_m,velocity_m_per_s,total_energy_j\n";

    for (int step = 0; step <= n_steps; ++step) {
        double energy = 0.5 * mass_kg * v * v + 0.5 * spring_constant * x * x;

        if (step % 10 == 0) {
            std::cout << std::setprecision(12)
                      << step << ","
                      << step * dt << ","
                      << x << ","
                      << v << ","
                      << energy << "\n";
        }

        v = v - dt * omega0_squared * x;
        x = x + dt * v;
    }

    return 0;
}
