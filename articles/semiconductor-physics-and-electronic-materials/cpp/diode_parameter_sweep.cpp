/*
Diode Parameter Sweep

This C++ workflow computes the ideal diode equation:

    I = Is[exp(V/(n Vt)) - 1]

where Vt = kB T / q.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    const double q = 1.602176634e-19;
    const double kb = 1.380649e-23;
    const double temperature = 300.0;
    const double vt = kb * temperature / q;

    std::vector<double> ideality_factors = {1.0, 1.5, 2.0};
    std::vector<double> saturation_currents = {1.0e-14, 1.0e-12, 1.0e-10};

    std::cout << "ideality_factor,saturation_current_a,voltage_v,current_a\n";

    for (double n : ideality_factors) {
        for (double is : saturation_currents) {
            for (double voltage = -0.2; voltage <= 0.800001; voltage += 0.1) {
                double exponent = voltage / (n * vt);
                if (exponent > 100.0) {
                    exponent = 100.0;
                }
                if (exponent < -100.0) {
                    exponent = -100.0;
                }

                double current = is * (std::exp(exponent) - 1.0);

                std::cout << std::setprecision(12)
                          << n << ","
                          << is << ","
                          << voltage << ","
                          << current << "\n";
            }
        }
    }

    return 0;
}
