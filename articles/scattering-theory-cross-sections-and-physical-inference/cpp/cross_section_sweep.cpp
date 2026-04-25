/*
Cross-Section Sweep

Computes the analytic total cross section for:

d sigma / d Omega = sigma0 * (1 + alpha cos^2 theta)
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double total_cross_section(double sigma0, double alpha) {
    return 4.0 * M_PI * sigma0 * (1.0 + alpha / 3.0);
}

int main() {
    std::vector<double> alphas = {0.0, 0.5, 1.0, 1.5, 2.0};

    std::cout << "sigma0,alpha,total_cross_section\n";

    for (double alpha : alphas) {
        double sigma0 = 1.0;
        std::cout << std::setprecision(12)
                  << sigma0 << ","
                  << alpha << ","
                  << total_cross_section(sigma0, alpha) << "\n";
    }

    return 0;
}
