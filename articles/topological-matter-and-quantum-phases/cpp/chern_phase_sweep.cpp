/*
Chern Phase Sweep

This C++ scaffold labels the broad phase regions of the two-band Chern model:

H(k) = sin(kx) sigma_x + sin(ky) sigma_y + (m + cos(kx) + cos(ky)) sigma_z

The exact sign convention for the Chern number depends on model convention.
This scaffold labels gap-closing boundaries and broad regimes.
*/

#include <cmath>
#include <iostream>
#include <string>
#include <vector>

std::string phase_label(double mass) {
    const double eps = 1e-12;

    if (std::abs(mass + 2.0) < eps || std::abs(mass) < eps || std::abs(mass - 2.0) < eps) {
        return "gap_closing_transition";
    }

    if (mass < -2.0) {
        return "trivial_large_negative_mass";
    }

    if (mass > 2.0) {
        return "trivial_large_positive_mass";
    }

    if (mass > -2.0 && mass < 0.0) {
        return "nontrivial_chern_region";
    }

    if (mass > 0.0 && mass < 2.0) {
        return "opposite_nontrivial_chern_region";
    }

    return "unclassified";
}

int main() {
    std::vector<double> masses = {-3.0, -2.0, -1.0, -0.1, 0.0, 0.1, 1.0, 2.0, 3.0};

    std::cout << "mass,phase_label\n";

    for (double mass : masses) {
        std::cout << mass << "," << phase_label(mass) << "\n";
    }

    return 0;
}
