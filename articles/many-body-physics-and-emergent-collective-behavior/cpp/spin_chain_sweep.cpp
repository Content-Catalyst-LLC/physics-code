/*
Spin Chain Sweep

This C++ workflow computes Hilbert-space dimensions and a simple
classical Ising chain energy for demonstration.
*/

#include <cmath>
#include <cstdint>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

std::uint64_t integer_power(std::uint64_t base, int exponent) {
    std::uint64_t result = 1;

    for (int i = 0; i < exponent; ++i) {
        result *= base;
    }

    return result;
}

double classical_ising_energy_all_aligned(int n_sites, double coupling_j) {
    return -coupling_j * static_cast<double>(n_sites);
}

int main() {
    std::cout << "n_sites,hilbert_dimension_spin_half,classical_aligned_energy_J1\n";

    for (int n_sites = 2; n_sites <= 32; n_sites += 2) {
        std::cout << n_sites << ","
                  << integer_power(2, n_sites) << ","
                  << std::setprecision(12)
                  << classical_ising_energy_all_aligned(n_sites, 1.0) << "\n";
    }

    return 0;
}
