/*
Detector Signal Chain Sweep

This C++ workflow simulates a simplified detector-style signal chain:

    output = gain * (signal + noise) + offset

It then applies a threshold decision.

This is educational scaffolding for thinking about detector response,
gain, noise, and trigger logic.
*/

#include <iomanip>
#include <iostream>
#include <vector>

struct SignalCase {
    double signal;
    double noise;
};

int main() {
    const double offset = 0.02;
    const double threshold = 1.50;

    std::vector<double> gains = {5.0, 10.0, 20.0};
    std::vector<SignalCase> cases = {
        {0.20, 0.03},
        {0.35, 0.05},
        {0.10, 0.04},
        {0.50, 0.06},
        {0.80, 0.08}
    };

    std::cout << "gain,true_signal,noise,analog_output,threshold,triggered,snr\n";

    for (double gain : gains) {
        for (const auto& item : cases) {
            double analog_output = gain * (item.signal + item.noise) + offset;
            bool triggered = analog_output >= threshold;
            double snr = item.signal / item.noise;

            std::cout << std::setprecision(10)
                      << gain << ","
                      << item.signal << ","
                      << item.noise << ","
                      << analog_output << ","
                      << threshold << ","
                      << triggered << ","
                      << snr << "\n";
        }
    }

    return 0;
}
