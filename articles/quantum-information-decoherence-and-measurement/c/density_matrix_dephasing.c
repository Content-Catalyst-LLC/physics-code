/*
Density Matrix Dephasing

This C workflow computes coherence, purity, and entropy for a dephased |+> state.
*/

#include <math.h>
#include <stdio.h>

double entropy_bits(double lambda_plus, double lambda_minus) {
    double entropy = 0.0;

    if (lambda_plus > 0.0) {
        entropy -= lambda_plus * (log(lambda_plus) / log(2.0));
    }

    if (lambda_minus > 0.0) {
        entropy -= lambda_minus * (log(lambda_minus) / log(2.0));
    }

    return entropy;
}

int main(void) {
    const double t2 = 5.0e-6;

    printf("time_microseconds,coherence_abs,purity,entropy_bits\n");

    for (int i = 0; i <= 25; i++) {
        double t = (double)i * 1.0e-6;
        double coherence = 0.5 * exp(-t / t2);

        double lambda_plus = 0.5 + coherence;
        double lambda_minus = 0.5 - coherence;

        double purity = lambda_plus * lambda_plus + lambda_minus * lambda_minus;
        double entropy = entropy_bits(lambda_plus, lambda_minus);

        printf("%.8f,%.10f,%.10f,%.10f\n",
               t * 1.0e6,
               coherence,
               purity,
               entropy);
    }

    return 0;
}
