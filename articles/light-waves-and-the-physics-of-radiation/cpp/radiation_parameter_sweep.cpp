/*
Radiation Parameter Sweep

This C++ workflow computes Wien peak wavelength and Stefan-Boltzmann exitance:

    lambda_max = b / T
    M = sigma T^4

for selected blackbody temperatures.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    const double wien_b_m_k = 2.897771955e-3;
    const double sigma = 5.670374419e-8;

    std::vector<double> temperatures_k = {3000.0, 4500.0, 5800.0, 6000.0, 10000.0};

    std::cout << "temperature_k,wien_peak_wavelength_nm,stefan_boltzmann_exitance_w_m2\n";

    for (double temperature_k : temperatures_k) {
        double peak_nm = (wien_b_m_k / temperature_k) * 1.0e9;
        double exitance = sigma * std::pow(temperature_k, 4);

        std::cout << std::setprecision(12)
                  << temperature_k << ","
                  << peak_nm << ","
                  << exitance << "\n";
    }

    return 0;
}
