/*
State Vector Probabilities

This C++ utility computes Born-rule probabilities for a simple
two-state vector.

Philosophical point:
The numerical prediction can be stable across different philosophical
interpretations of the state vector.
*/

#include <cmath>
#include <iostream>
#include <vector>

double probability(double amplitude) {
    return amplitude * amplitude;
}

int main() {
    const double inv_sqrt_2 = 1.0 / std::sqrt(2.0);
    std::vector<double> state = {inv_sqrt_2, inv_sqrt_2};

    std::cout << "basis_index,amplitude,probability\n";

    for (std::size_t i = 0; i < state.size(); ++i) {
        std::cout << i << "," << state[i] << "," << probability(state[i]) << "\n";
    }

    return 0;
}
