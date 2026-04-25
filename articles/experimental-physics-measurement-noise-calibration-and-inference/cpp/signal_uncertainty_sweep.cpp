/*
Signal Uncertainty Sweep

This C++ workflow computes signal-to-noise ratio and resistance
uncertainty for several example cases.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>
#include <string>

struct SNRCase {
    std::string case_id;
    double signal_rms;
    double noise_rms;
};

double snr_db(double signal_rms, double noise_rms) {
    return 20.0 * std::log10(signal_rms / noise_rms);
}

double resistance_uncertainty(double voltage, double u_voltage, double current, double u_current) {
    double resistance = voltage / current;
    double relative = std::sqrt(std::pow(u_voltage / voltage, 2.0) + std::pow(u_current / current, 2.0));
    return resistance * relative;
}

int main() {
    std::vector<SNRCase> cases = {
        {"article_demo", 1.414213562, 0.25},
        {"low_snr", 0.353553391, 0.50},
        {"high_snr", 1.414213562, 0.05}
    };

    std::cout << "case_id,signal_rms,noise_rms,snr_linear,snr_db\n";

    for (const auto& item : cases) {
        double snr_linear = item.signal_rms / item.noise_rms;

        std::cout << std::setprecision(12)
                  << item.case_id << ","
                  << item.signal_rms << ","
                  << item.noise_rms << ","
                  << snr_linear << ","
                  << snr_db(item.signal_rms, item.noise_rms) << "\n";
    }

    std::cout << "\nquantity,value\n";
    std::cout << "resistance_uncertainty_ohm,"
              << resistance_uncertainty(10.0, 0.02, 2.0, 0.005)
              << "\n";

    return 0;
}
