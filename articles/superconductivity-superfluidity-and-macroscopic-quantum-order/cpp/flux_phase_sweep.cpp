/*
Flux and Phase Sweep

This C++ workflow computes superconducting flux quantum states.
*/

#include <iomanip>
#include <iostream>

int main() {
    const double flux_quantum = 2.067833848e-15;

    std::cout << "n,flux_wb\n";

    for (int n = -5; n <= 5; ++n) {
        std::cout << n << ","
                  << std::setprecision(12)
                  << n * flux_quantum << "\n";
    }

    return 0;
}
