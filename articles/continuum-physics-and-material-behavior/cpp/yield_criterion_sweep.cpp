/*
Yield Criterion Sweep

This C++ workflow computes von Mises stress from principal stresses:

sigma_vM = sqrt(0.5*((s1-s2)^2 + (s2-s3)^2 + (s3-s1)^2))
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

struct StressCase {
    std::string case_id;
    double s1_mpa;
    double s2_mpa;
    double s3_mpa;
    double yield_strength_mpa;
};

double von_mises_principal(double s1, double s2, double s3) {
    return std::sqrt(
        0.5 * (
            std::pow(s1 - s2, 2.0)
            + std::pow(s2 - s3, 2.0)
            + std::pow(s3 - s1, 2.0)
        )
    );
}

int main() {
    std::vector<StressCase> cases = {
        {"low_stress", 100.0, 50.0, 20.0, 250.0},
        {"moderate_stress", 180.0, 60.0, 10.0, 250.0},
        {"near_yield", 260.0, 40.0, 30.0, 250.0},
        {"pure_hydrostatic", -100.0, -100.0, -100.0, 250.0}
    };

    std::cout << "case_id,s1_mpa,s2_mpa,s3_mpa,von_mises_mpa,yield_strength_mpa,yield_ratio,yield_flag\n";

    for (const auto& c : cases) {
        double vm = von_mises_principal(c.s1_mpa, c.s2_mpa, c.s3_mpa);
        double ratio = vm / c.yield_strength_mpa;

        std::cout << std::setprecision(12)
                  << c.case_id << ","
                  << c.s1_mpa << ","
                  << c.s2_mpa << ","
                  << c.s3_mpa << ","
                  << vm << ","
                  << c.yield_strength_mpa << ","
                  << ratio << ","
                  << (ratio >= 1.0 ? "true" : "false") << "\n";
    }

    return 0;
}
