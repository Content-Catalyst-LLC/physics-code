/*
Rotation Curve Sweep

This C++ workflow computes enclosed mass for a sweep of radius and
velocity values:

    M(r) = v^2 r / G

It demonstrates a performance-oriented loop pattern for galaxy-dynamics
scaffolding.
*/

#include <iomanip>
#include <iostream>
#include <vector>

const double G_SI = 6.67430e-11;
const double M_SUN_KG = 1.98847e30;
const double KPC_TO_M = 3.085677581491367e19;

double enclosed_mass_solar(double radius_kpc, double velocity_km_s) {
    double radius_m = radius_kpc * KPC_TO_M;
    double velocity_m_s = velocity_km_s * 1000.0;
    double mass_kg = velocity_m_s * velocity_m_s * radius_m / G_SI;
    return mass_kg / M_SUN_KG;
}

int main() {
    std::vector<double> radii_kpc = {2.0, 5.0, 10.0, 15.0, 20.0, 30.0, 50.0};
    std::vector<double> velocities_km_s = {100.0, 150.0, 200.0, 220.0, 250.0, 300.0};

    std::cout << "radius_kpc,velocity_km_s,enclosed_mass_solar\n";

    for (double radius_kpc : radii_kpc) {
        for (double velocity_km_s : velocities_km_s) {
            std::cout << std::setprecision(10)
                      << radius_kpc << ","
                      << velocity_km_s << ","
                      << enclosed_mass_solar(radius_kpc, velocity_km_s) << "\n";
        }
    }

    return 0;
}
