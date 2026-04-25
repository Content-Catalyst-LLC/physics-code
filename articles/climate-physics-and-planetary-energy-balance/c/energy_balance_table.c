/*
Energy Balance Table

This C workflow computes:
    ASR = S0(1-alpha)/4
    Te = (ASR/sigma)^(1/4)
    DeltaF = 5.35 log(C/C0)
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    const double solar_constant = 1361.0;
    const double sigma_sb = 5.670374419e-8;
    const double co2_reference = 280.0;

    double albedos[] = {0.25, 0.30, 0.35};
    double co2_values[] = {280.0, 420.0, 560.0, 700.0};

    int n_albedo = sizeof(albedos) / sizeof(albedos[0]);
    int n_co2 = sizeof(co2_values) / sizeof(co2_values[0]);

    printf("albedo,co2_ppm,asr_w_m2,te_k,co2_forcing_w_m2\n");

    for (int i = 0; i < n_albedo; i++) {
        double albedo = albedos[i];
        double asr = solar_constant * (1.0 - albedo) / 4.0;
        double te = pow(asr / sigma_sb, 0.25);

        for (int j = 0; j < n_co2; j++) {
            double co2 = co2_values[j];
            double forcing = 5.35 * log(co2 / co2_reference);

            printf("%.6f,%.6f,%.8f,%.8f,%.8f\n",
                   albedo,
                   co2,
                   asr,
                   te,
                   forcing);
        }
    }

    return 0;
}
