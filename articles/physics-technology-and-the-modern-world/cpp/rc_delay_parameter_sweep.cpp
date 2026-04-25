/*
RC Delay Parameter Sweep

This C++ workflow computes a simplified RC delay relation:

    tau = R * C

where:
    tau = delay in seconds
    R = resistance in ohms
    C = capacitance in farads

The example is intentionally simple but useful for performance-oriented
parameter sweep patterns in device-style modeling.
*/

#include <iomanip>
#include <iostream>
#include <vector>

int main() {
    std::vector<double> resistances_ohm = {10.0, 50.0, 100.0, 500.0, 1000.0};
    std::vector<double> capacitances_f = {1e-15, 5e-15, 1e-14, 5e-14, 1e-13};

    std::cout << "resistance_ohm,capacitance_f,delay_s,delay_ps\n";

    for (double resistance_ohm : resistances_ohm) {
        for (double capacitance_f : capacitances_f) {
            double delay_s = resistance_ohm * capacitance_f;
            double delay_ps = delay_s * 1e12;

            std::cout << std::setprecision(10)
                      << resistance_ohm << ","
                      << capacitance_f << ","
                      << delay_s << ","
                      << delay_ps << "\n";
        }
    }

    return 0;
}
