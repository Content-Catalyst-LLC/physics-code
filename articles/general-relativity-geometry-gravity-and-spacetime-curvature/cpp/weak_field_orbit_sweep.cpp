/*
Weak Field Orbit Sweep

This C++ workflow computes analytic Schwarzschild precession estimates:

    Delta omega = 6 pi G M / [a (1 - e^2) c^2]

per orbit for simple orbital cases.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>
#include <string>

struct OrbitCase {
    std::string case_id;
    double central_mass_kg;
    double semi_major_axis_m;
    double eccentricity;
};

int main() {
    const double G = 6.67430e-11;
    const double C = 299792458.0;
    const double arcsec_per_rad = 206264.806247;

    std::vector<OrbitCase> cases = {
        {"mercury_like", 1.98847e30, 5.7909e10, 0.2056},
        {"earth_like", 1.98847e30, 1.495978707e11, 0.0167},
        {"compact_test", 1.98847e30, 1.0e10, 0.2}
    };

    std::cout << "case_id,precession_rad_per_orbit,precession_arcsec_per_orbit\n";

    for (const auto& item : cases) {
        double precession = 6.0 * M_PI * G * item.central_mass_kg /
            (item.semi_major_axis_m * (1.0 - item.eccentricity * item.eccentricity) * C * C);

        std::cout << std::setprecision(12)
                  << item.case_id << ","
                  << precession << ","
                  << precession * arcsec_per_rad << "\n";
    }

    return 0;
}
