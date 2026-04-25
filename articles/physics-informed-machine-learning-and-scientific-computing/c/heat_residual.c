/*
Heat Equation Residual

Computes analytic residual for:

u(x,t) = exp(-D*pi^2*t) sin(pi*x)
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double D = 0.1;
    const double pi = acos(-1.0);

    printf("x,t,u,residual\n");

    for (double x = 0.1; x <= 0.9001; x += 0.2) {
        for (double t = 0.0; t <= 1.0001; t += 0.25) {
            double common = exp(-D * pi * pi * t) * sin(pi * x);
            double u = common;
            double u_t = -D * pi * pi * common;
            double u_xx = -pi * pi * common;
            double residual = u_t - D * u_xx;

            printf("%.6f,%.6f,%.12e,%.12e\n", x, t, u, residual);
        }
    }

    return 0;
}
