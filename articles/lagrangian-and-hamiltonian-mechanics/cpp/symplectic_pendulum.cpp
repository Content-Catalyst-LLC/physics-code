/*
Symplectic Pendulum Integration

This C++ workflow integrates the simple pendulum Hamiltonian using
symplectic Euler.
*/

#include <cmath>
#include <iomanip>
#include <iostream>

const double MASS_KG = 1.0;
const double LENGTH_M = 1.0;
const double G = 9.80665;
const double DT = 0.01;
const int N_STEPS = 5000;

double hamiltonian(double theta, double p) {
    double kinetic = p * p / (2.0 * MASS_KG * LENGTH_M * LENGTH_M);
    double potential = MASS_KG * G * LENGTH_M * (1.0 - std::cos(theta));
    return kinetic + potential;
}

double wrap_angle(double theta) {
    const double pi = 3.14159265358979323846;
    return std::fmod(theta + pi, 2.0 * pi) - pi;
}

int main() {
    double theta = 1.0;
    double p = 0.0;
    double initial_energy = hamiltonian(theta, p);

    std::cout << "step,time_s,theta_rad,p_theta_kg_m2_per_s,hamiltonian_j,energy_error_j\n";

    for (int step = 0; step <= N_STEPS; ++step) {
        double energy = hamiltonian(theta, p);

        if (step % 100 == 0) {
            std::cout << std::setprecision(12)
                      << step << ","
                      << step * DT << ","
                      << theta << ","
                      << p << ","
                      << energy << ","
                      << energy - initial_energy << "\n";
        }

        p = p - DT * MASS_KG * G * LENGTH_M * std::sin(theta);
        theta = theta + DT * p / (MASS_KG * LENGTH_M * LENGTH_M);
        theta = wrap_angle(theta);
    }

    return 0;
}
