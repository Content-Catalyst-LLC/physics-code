/*
C3 Character Table

This C workflow prints real and imaginary parts of the C3 complex
character table using elementary trigonometry.
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double pi = acos(-1.0);
    const double omega_real = cos(2.0 * pi / 3.0);
    const double omega_imag = sin(2.0 * pi / 3.0);
    const double omega2_real = cos(4.0 * pi / 3.0);
    const double omega2_imag = sin(4.0 * pi / 3.0);

    printf("irrep,element,character_real,character_imag\n");

    printf("Gamma_0,e,1.000000000000,0.000000000000\n");
    printf("Gamma_0,r,1.000000000000,0.000000000000\n");
    printf("Gamma_0,r2,1.000000000000,0.000000000000\n");

    printf("Gamma_1,e,1.000000000000,0.000000000000\n");
    printf("Gamma_1,r,%.12f,%.12f\n", omega_real, omega_imag);
    printf("Gamma_1,r2,%.12f,%.12f\n", omega2_real, omega2_imag);

    printf("Gamma_2,e,1.000000000000,0.000000000000\n");
    printf("Gamma_2,r,%.12f,%.12f\n", omega2_real, omega2_imag);
    printf("Gamma_2,r2,%.12f,%.12f\n", omega_real, omega_imag);

    return 0;
}
