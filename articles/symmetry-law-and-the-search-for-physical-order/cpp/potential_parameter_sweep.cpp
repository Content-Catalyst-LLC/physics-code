/*
Potential Parameter Sweep

This C++ workflow evaluates a double-well potential:

    V(x) = -a*x^2 + b*x^4 + tilt*x

The tilt parameter explicitly breaks reflection symmetry when nonzero.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double double_well_potential(double x, double a, double b, double tilt) {
    return -a * x * x + b * x * x * x * x + tilt * x;
}

int main() {
    std::vector<double> tilt_values = {0.0, 0.1, 0.25};
    const double a = 1.0;
    const double b = 0.25;

    std::cout << "tilt,x,potential,reflected_potential,difference\n";

    for (double tilt : tilt_values) {
        for (double x = -3.0; x <= 3.000001; x += 0.5) {
            double potential = double_well_potential(x, a, b, tilt);
            double reflected = double_well_potential(-x, a, b, tilt);
            double difference = potential - reflected;

            std::cout << std::setprecision(10)
                      << tilt << ","
                      << x << ","
                      << potential << ","
                      << reflected << ","
                      << difference << "\n";
        }
    }

    return 0;
}
