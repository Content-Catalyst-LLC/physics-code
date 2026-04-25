/*
Relativistic Parameter Sweep

This C++ workflow computes:

    gamma = 1 / sqrt(1 - beta^2)

and collinear velocity composition:

    beta_prime = (beta_u - beta_v) / (1 - beta_u beta_v)
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double lorentz_factor(double beta) {
    if (std::abs(beta) >= 1.0) {
        throw std::runtime_error("beta must satisfy |beta| < 1");
    }

    return 1.0 / std::sqrt(1.0 - beta * beta);
}

double compose_beta(double beta_u, double beta_v) {
    if (std::abs(beta_u) >= 1.0 || std::abs(beta_v) >= 1.0) {
        throw std::runtime_error("all beta values must satisfy |beta| < 1");
    }

    return (beta_u - beta_v) / (1.0 - beta_u * beta_v);
}

int main() {
    std::vector<double> betas = {0.0, 0.1, 0.3, 0.5, 0.8, 0.9, 0.99};

    std::cout << "beta,gamma,relativistic_ke_scaled,newtonian_ke_scaled\n";

    for (double beta : betas) {
        double gamma = lorentz_factor(beta);
        double relativistic_ke_scaled = gamma - 1.0;
        double newtonian_ke_scaled = 0.5 * beta * beta;

        std::cout << std::setprecision(12)
                  << beta << ","
                  << gamma << ","
                  << relativistic_ke_scaled << ","
                  << newtonian_ke_scaled << "\n";
    }

    std::cout << "\nbeta_u,beta_v,beta_prime\n";

    for (double beta_u : {0.3, 0.5, 0.8}) {
        for (double beta_v : {0.1, 0.3, 0.5}) {
            std::cout << std::setprecision(12)
                      << beta_u << ","
                      << beta_v << ","
                      << compose_beta(beta_u, beta_v) << "\n";
        }
    }

    return 0;
}
