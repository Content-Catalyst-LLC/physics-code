#include <iostream>
#include <vector>

double kinetic_energy(double mass_kg, double velocity_m_per_s) {
    return 0.5 * mass_kg * velocity_m_per_s * velocity_m_per_s;
}

int main() {
    std::vector<double> masses = {1.0, 2.0, 5.0};
    std::vector<double> velocities = {3.0, 4.0, 5.0};

    for (std::size_t i = 0; i < masses.size(); ++i) {
        std::cout << "KE = " << kinetic_energy(masses[i], velocities[i]) << " J\n";
    }

    return 0;
}
