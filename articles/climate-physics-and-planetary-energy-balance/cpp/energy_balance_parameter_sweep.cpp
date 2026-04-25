/*
Energy Balance Parameter Sweep

This C++ workflow computes:
    ASR = S0(1-alpha)/4
    Te = (ASR/sigma)^(1/4)
    F = 5.35 log(C/C0)
    DeltaT = F/lambda
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    const double solar_constant = 1361.0;
    const double sigma_sb = 5.670374419e-8;
    const double co2_reference = 280.0;

    std::vector<double> albedos = {0.25, 0.30, 0.35};
    std::vector<double> feedbacks = {0.8, 1.2, 1.6};
    std::vector<double> co2_values = {280.0, 420.0, 560.0, 700.0};

    std::cout << "albedo,feedback_w_m2_k,co2_ppm,asr_w_m2,te_k,forcing_w_m2,equilibrium_warming_k\n";

    for (double albedo : albedos) {
        double asr = solar_constant * (1.0 - albedo) / 4.0;
        double te = std::pow(asr / sigma_sb, 0.25);

        for (double feedback : feedbacks) {
            for (double co2 : co2_values) {
                double forcing = 5.35 * std::log(co2 / co2_reference);
                double warming = forcing / feedback;

                std::cout << std::setprecision(12)
                          << albedo << ","
                          << feedback << ","
                          << co2 << ","
                          << asr << ","
                          << te << ","
                          << forcing << ","
                          << warming << "\n";
            }
        }
    }

    return 0;
}
