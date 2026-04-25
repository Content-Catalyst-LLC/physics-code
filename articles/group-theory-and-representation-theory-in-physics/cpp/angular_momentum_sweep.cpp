/*
Angular Momentum Sweep

This C++ workflow computes spin-j representation dimensions
and Casimir eigenvalues in hbar = 1 units.
*/

#include <iomanip>
#include <iostream>
#include <vector>

double casimir_eigenvalue(double j, double hbar) {
    return hbar * hbar * j * (j + 1.0);
}

int spin_dimension(double j) {
    return static_cast<int>(2.0 * j + 1.0);
}

int main() {
    std::vector<double> spin_values = {0.5, 1.0, 1.5, 2.0, 3.0, 4.0};

    std::cout << "j,dimension,casimir_eigenvalue_hbar1\n";

    for (double j : spin_values) {
        std::cout << std::setprecision(12)
                  << j << ","
                  << spin_dimension(j) << ","
                  << casimir_eigenvalue(j, 1.0) << "\n";
    }

    return 0;
}
