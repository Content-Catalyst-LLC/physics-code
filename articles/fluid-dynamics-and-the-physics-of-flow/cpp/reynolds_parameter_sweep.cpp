/*
Reynolds Number Parameter Sweep

This C++ workflow computes:

    Re = rho * v * L / mu
*/

#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

struct FlowCase {
    std::string case_id;
    double rho;
    double velocity;
    double length;
    double viscosity;
};

std::string classify_reynolds(double re) {
    if (re < 2300.0) {
        return "laminar";
    }
    if (re <= 4000.0) {
        return "transitional";
    }
    return "turbulent";
}

int main() {
    std::vector<FlowCase> cases = {
        {"slow_water_small_pipe", 1000.0, 0.02, 0.01, 1.0e-3},
        {"moderate_water_pipe", 1000.0, 0.50, 0.05, 1.0e-3},
        {"fast_water_pipe", 1000.0, 2.00, 0.10, 1.0e-3},
        {"viscous_oil_pipe", 850.0, 0.20, 0.04, 0.20},
        {"microfluidic_channel", 1000.0, 0.001, 0.0001, 1.0e-3},
        {"air_duct", 1.204, 5.0, 0.20, 1.81e-5}
    };

    std::cout << "case_id,density_kg_per_m3,velocity_m_per_s,length_m,viscosity_pa_s,reynolds_number,flow_regime\n";

    for (const auto& c : cases) {
        double re = c.rho * c.velocity * c.length / c.viscosity;

        std::cout << std::setprecision(12)
                  << c.case_id << ","
                  << c.rho << ","
                  << c.velocity << ","
                  << c.length << ","
                  << c.viscosity << ","
                  << re << ","
                  << classify_reynolds(re) << "\n";
    }

    return 0;
}
