/*
Logistic Map Sweep

This C++ workflow iterates:

    x_{n+1} = r x_n (1 - x_n)

for selected r values.
*/

#include <iomanip>
#include <iostream>
#include <vector>

double logistic_step(double r, double x) {
    return r * x * (1.0 - x);
}

int main() {
    std::vector<double> r_values = {2.8, 3.2, 3.5, 3.9};
    const int n_iter = 1200;
    const int burn_in = 1180;

    std::cout << "r,iteration,x\n";

    for (double r : r_values) {
        double x = 0.2;

        for (int iteration = 1; iteration <= n_iter; ++iteration) {
            x = logistic_step(r, x);

            if (iteration > burn_in) {
                std::cout << std::setprecision(12)
                          << r << ","
                          << iteration << ","
                          << x << "\n";
            }
        }
    }

    return 0;
}
