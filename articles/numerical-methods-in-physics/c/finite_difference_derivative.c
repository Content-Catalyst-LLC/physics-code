/*
Finite Difference Derivative

Computes central-difference derivative error for sin(x).
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    double x = 1.0;
    double exact = cos(x);

    printf("dx,numeric_derivative,exact_derivative,absolute_error\n");

    for (int power = -2; power >= -20; power--) {
        double dx = pow(2.0, power);
        double numeric = (sin(x + dx) - sin(x - dx)) / (2.0 * dx);
        double error = fabs(numeric - exact);

        printf("%.16e,%.16e,%.16e,%.16e\n", dx, numeric, exact, error);
    }

    return 0;
}
