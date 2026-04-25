/*
Hydrogen Transition Energy Sweep

This C++ workflow computes Bohr-like transition energies:

    E_n = -13.6 / n^2

For a transition from n_i to n_f:

    Delta E = |E_f - E_i|

This is an introductory atomic-physics scaffold.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double bohr_energy_ev(int n) {
    return -13.6 / static_cast<double>(n * n);
}

double transition_energy_ev(int initial_n, int final_n) {
    return std::abs(bohr_energy_ev(final_n) - bohr_energy_ev(initial_n));
}

int main() {
    std::vector<int> initial_levels = {3, 4, 5, 6, 7, 8};
    int final_n = 2;

    std::cout << "initial_n,final_n,transition_energy_ev\n";

    for (int initial_n : initial_levels) {
        std::cout << std::setprecision(10)
                  << initial_n << ","
                  << final_n << ","
                  << transition_energy_ev(initial_n, final_n) << "\n";
    }

    return 0;
}
