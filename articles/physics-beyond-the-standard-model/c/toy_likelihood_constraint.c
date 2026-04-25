/*
Toy Likelihood Constraint

This C example computes a simple chi-square-like quantity:

    chi2 = ((prediction - observed) / sigma)^2

This is not a real experimental likelihood. It is a minimal scaffold for
thinking about constraint logic in BSM parameter scans.
*/

#include <math.h>
#include <stdio.h>

double chi_square(double prediction, double observed, double uncertainty) {
    double residual = prediction - observed;
    return (residual * residual) / (uncertainty * uncertainty);
}

int main(void) {
    const double observed = 0.12;
    const double uncertainty = 0.01;
    const double predictions[] = {0.08, 0.10, 0.11, 0.12, 0.13, 0.15};
    const int n_predictions = 6;

    printf("prediction,observed,uncertainty,chi_square\n");

    for (int i = 0; i < n_predictions; i++) {
        double chi2 = chi_square(predictions[i], observed, uncertainty);
        printf("%.6f,%.6f,%.6f,%.6f\n", predictions[i], observed, uncertainty, chi2);
    }

    return 0;
}
