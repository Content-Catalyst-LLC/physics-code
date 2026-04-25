/*
Heat Equation Residual Sweep

Computes analytic residual for:

u(x,t) = exp(-D*pi^2*t) sin(pi*x)

The exact residual u_t - D u_xx should be zero up to floating-point error.
*/

#include <cmath>
#include <iomanip>
#include <iostream>

int main() {
    const double D = 0.1;
    const double pi = std::acos(-1.0);

    std::cout << "x,t,u,residual\n";

    for (double x = 0.1; x <= 0.9001; x += 0.2) {
        for (double t = 0.0; t <= 1.0001; t += 0.25) {
            double common = std::exp(-D * pi * pi * t) * std::sin(pi * x);
            double u = common;
            double u_t = -D * pi * pi * common;
            double u_xx = -pi * pi * common;
            double residual = u_t - D * u_xx;

            std::cout << std::setprecision(12)
                      << x << ","
                      << t << ","
                      << u << ","
                      << residual << "\n";
        }
    }

    return 0;
}
