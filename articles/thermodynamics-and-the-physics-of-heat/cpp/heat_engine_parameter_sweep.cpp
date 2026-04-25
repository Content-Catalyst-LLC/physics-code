/*
Heat Engine Parameter Sweep

This C++ workflow computes ideal Carnot efficiency:

    eta = 1 - Tc/Th

for selected hot and cold reservoir temperatures.
*/

#include <iomanip>
#include <iostream>
#include <vector>

double carnot_efficiency(double hot_temperature_k, double cold_temperature_k) {
    return 1.0 - cold_temperature_k / hot_temperature_k;
}

int main() {
    std::vector<double> hot_temperatures_k = {500.0, 700.0, 900.0, 1200.0};
    std::vector<double> cold_temperatures_k = {250.0, 300.0, 350.0};

    std::cout << "hot_temperature_k,cold_temperature_k,carnot_efficiency\n";

    for (double th : hot_temperatures_k) {
        for (double tc : cold_temperatures_k) {
            if (th > tc) {
                std::cout << std::setprecision(12)
                          << th << ","
                          << tc << ","
                          << carnot_efficiency(th, tc) << "\n";
            }
        }
    }

    return 0;
}
