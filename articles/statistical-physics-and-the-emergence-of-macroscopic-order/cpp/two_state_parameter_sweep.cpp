/*
Two-State Parameter Sweep

This C++ workflow computes:

    Z = 1 + exp(-beta epsilon)
    p_exc = exp(-beta epsilon) / Z
    <E> = epsilon * p_exc
    F = -k_B T ln Z

for selected temperatures.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    const double k_b = 1.380649e-23;
    const double epsilon_j = 2.0e-21;

    std::vector<double> temperatures_k = {100.0, 150.0, 300.0, 600.0, 1000.0};

    std::cout << "temperature_k,beta_per_joule,partition_function,p_excited,mean_energy_j,free_energy_j\n";

    for (double temperature_k : temperatures_k) {
        double beta = 1.0 / (k_b * temperature_k);
        double boltzmann_factor = std::exp(-beta * epsilon_j);
        double z = 1.0 + boltzmann_factor;
        double p_excited = boltzmann_factor / z;
        double mean_energy = epsilon_j * p_excited;
        double free_energy = -k_b * temperature_k * std::log(z);

        std::cout << std::setprecision(12)
                  << temperature_k << ","
                  << beta << ","
                  << z << ","
                  << p_excited << ","
                  << mean_energy << ","
                  << free_energy << "\n";
    }

    return 0;
}
