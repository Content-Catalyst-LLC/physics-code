/*
Fock Space Sweep

This C++ workflow computes harmonic oscillator energies
for finite Fock-space truncations.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>
#include <string>

struct FockCase {
    std::string case_id;
    int dimension;
    double hbar;
    double omega;
};

double energy(double hbar, double omega, int n) {
    return hbar * omega * (static_cast<double>(n) + 0.5);
}

int main() {
    std::vector<FockCase> cases = {
        {"small_truncation", 4, 1.0, 1.0},
        {"article_example", 8, 1.0, 2.0},
        {"larger_truncation", 16, 1.0, 0.5},
        {"high_frequency", 10, 1.0, 5.0}
    };

    std::cout << "case_id,n,energy\n";

    for (const auto& item : cases) {
        for (int n = 0; n < item.dimension; ++n) {
            std::cout << std::setprecision(12)
                      << item.case_id << ","
                      << n << ","
                      << energy(item.hbar, item.omega, n) << "\n";
        }
    }

    return 0;
}
