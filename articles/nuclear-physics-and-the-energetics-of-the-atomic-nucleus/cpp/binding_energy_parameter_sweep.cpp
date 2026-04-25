/*
Binding Energy Parameter Sweep

This C++ workflow computes a simplified semi-empirical mass-formula estimate:

    B(A,Z) = a_v A
           - a_s A^(2/3)
           - a_c Z(Z-1)/A^(1/3)
           - a_a(A-2Z)^2/A
           + delta(A,Z)

This is educational scaffolding for broad binding-energy trends.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double pairing_term(int A, int Z, double pairing_coefficient = 12.0) {
    int N = A - Z;

    if (A % 2 == 1) {
        return 0.0;
    }

    if (Z % 2 == 0 && N % 2 == 0) {
        return pairing_coefficient / std::sqrt(static_cast<double>(A));
    }

    return -pairing_coefficient / std::sqrt(static_cast<double>(A));
}

double semf_binding_energy(int A, int Z) {
    const double a_v = 15.75;
    const double a_s = 17.80;
    const double a_c = 0.711;
    const double a_a = 23.70;

    double A_double = static_cast<double>(A);
    double Z_double = static_cast<double>(Z);

    double volume = a_v * A_double;
    double surface = a_s * std::pow(A_double, 2.0 / 3.0);
    double coulomb = a_c * Z_double * (Z_double - 1.0) / std::pow(A_double, 1.0 / 3.0);
    double asymmetry = a_a * std::pow(A_double - 2.0 * Z_double, 2.0) / A_double;
    double pairing = pairing_term(A, Z);

    return volume - surface - coulomb - asymmetry + pairing;
}

int main() {
    std::vector<std::pair<int, int>> isotopes = {
        {4, 2},
        {12, 6},
        {14, 6},
        {56, 26},
        {60, 27},
        {131, 53},
        {238, 92}
    };

    std::cout << "A,Z,N,semf_binding_energy_mev,binding_energy_per_nucleon_mev\n";

    for (const auto& isotope : isotopes) {
        int A = isotope.first;
        int Z = isotope.second;
        int N = A - Z;
        double B = semf_binding_energy(A, Z);

        std::cout << std::setprecision(10)
                  << A << ","
                  << Z << ","
                  << N << ","
                  << B << ","
                  << B / static_cast<double>(A) << "\n";
    }

    return 0;
}
