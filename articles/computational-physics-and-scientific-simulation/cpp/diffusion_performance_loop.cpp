/*
Diffusion Performance Loop

This C++ workflow solves a one-dimensional diffusion equation using an
explicit finite-difference method.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    const double length_m = 1.0;
    const int n_grid = 201;
    const double diffusivity = 0.001;
    const double dt = 0.0002;
    const int n_steps = 1200;

    const double dx = length_m / static_cast<double>(n_grid - 1);
    const double s = diffusivity * dt / (dx * dx);

    if (s > 0.5) {
        std::cerr << "Explicit diffusion stability condition violated.\n";
        return 1;
    }

    std::vector<double> field(n_grid, 0.0);
    std::vector<double> next_field(n_grid, 0.0);

    for (int i = 0; i < n_grid; ++i) {
        double x = i * dx;
        field[i] = std::exp(-std::pow(x - 0.5, 2.0) / (2.0 * 0.04 * 0.04));
    }

    std::cout << "step,time_s,total_integral,max_field,stability_number\n";

    for (int step = 0; step <= n_steps; ++step) {
        if (step % 300 == 0) {
            double total = 0.0;
            double max_value = field[0];

            for (double value : field) {
                total += value * dx;
                if (value > max_value) {
                    max_value = value;
                }
            }

            std::cout << std::setprecision(12)
                      << step << ","
                      << step * dt << ","
                      << total << ","
                      << max_value << ","
                      << s << "\n";
        }

        next_field = field;

        for (int i = 1; i < n_grid - 1; ++i) {
            next_field[i] = field[i] + s * (field[i + 1] - 2.0 * field[i] + field[i - 1]);
        }

        next_field[0] = 0.0;
        next_field[n_grid - 1] = 0.0;

        field.swap(next_field);
    }

    return 0;
}
