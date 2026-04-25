/*
Euclidean Action Sweep

This C++ workflow computes discretized Euclidean harmonic oscillator action
for sinusoidal paths with varying amplitudes.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double euclidean_action(const std::vector<double>& path, double mass, double omega, double delta_tau) {
    double total = 0.0;
    const int n = static_cast<int>(path.size());

    for (int i = 0; i < n; ++i) {
        int next = (i + 1) % n;

        double kinetic = mass / (2.0 * delta_tau) * std::pow(path[next] - path[i], 2.0);
        double potential = 0.5 * delta_tau * mass * omega * omega * path[i] * path[i];

        total += kinetic + potential;
    }

    return total;
}

int main() {
    const int n_steps = 128;
    const double beta = 4.0;
    const double delta_tau = beta / n_steps;
    const double mass = 1.0;
    const double omega = 1.0;

    std::cout << "amplitude,euclidean_action,path_weight\n";

    for (double amplitude = 0.0; amplitude <= 2.0; amplitude += 0.25) {
        std::vector<double> path(n_steps);

        for (int i = 0; i < n_steps; ++i) {
            double tau = i * delta_tau;
            path[i] = amplitude * std::sin(2.0 * M_PI * tau / beta);
        }

        double action = euclidean_action(path, mass, omega, delta_tau);

        std::cout << std::setprecision(12)
                  << amplitude << ","
                  << action << ","
                  << std::exp(-action) << "\n";
    }

    return 0;
}
