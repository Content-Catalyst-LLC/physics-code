/*
Finite Difference Sweep

Computes central-difference derivative error for sin(x):

u'(x) ≈ [u(x + dx) - u(x - dx)] / (2 dx)
*/

#include <cmath>
#include <iomanip>
#include <iostream>

int main() {
    const double x = 1.0;
    const double exact = std::cos(x);

    std::cout << "dx,numeric_derivative,exact_derivative,absolute_error\n";

    for (int power = -2; power >= -20; --power) {
        double dx = std::pow(2.0, power);
        double numeric = (std::sin(x + dx) - std::sin(x - dx)) / (2.0 * dx);
        double error = std::abs(numeric - exact);

        std::cout << std::setprecision(16)
                  << dx << ","
                  << numeric << ","
                  << exact << ","
                  << error << "\n";
    }

    return 0;
}
