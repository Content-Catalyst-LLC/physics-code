/*
Dephasing Channel Sweep

This C++ workflow computes diagnostics for the dephased |+> density matrix:

    rho(t) = 1/2 [[1, exp(-t/T2)], [exp(-t/T2), 1]]
*/

#include <cmath>
#include <iomanip>
#include <iostream>

double entropy_bits_from_eigenvalues(double lambda_plus, double lambda_minus) {
    double entropy = 0.0;

    if (lambda_plus > 0.0) {
        entropy -= lambda_plus * std::log2(lambda_plus);
    }

    if (lambda_minus > 0.0) {
        entropy -= lambda_minus * std::log2(lambda_minus);
    }

    return entropy;
}

int main() {
    const double t2 = 5.0e-6;

    std::cout << "time_microseconds,coherence_abs,purity,entropy_bits\n";

    for (int i = 0; i <= 25; ++i) {
        double t = static_cast<double>(i) * 1.0e-6;
        double coherence = 0.5 * std::exp(-t / t2);

        double lambda_plus = 0.5 + coherence;
        double lambda_minus = 0.5 - coherence;

        double purity = lambda_plus * lambda_plus + lambda_minus * lambda_minus;
        double entropy = entropy_bits_from_eigenvalues(lambda_plus, lambda_minus);

        std::cout << std::setprecision(12)
                  << t * 1.0e6 << ","
                  << coherence << ","
                  << purity << ","
                  << entropy << "\n";
    }

    return 0;
}
