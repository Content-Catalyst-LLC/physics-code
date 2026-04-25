/*
Biophysics Parameter Sweep

This C++ workflow computes diffusion time, binding occupancy,
Nernst potential, and Michaelis-Menten rate.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

double diffusion_time(double length_um, double diffusion_um2_s, double dimension) {
    return length_um * length_um / (2.0 * dimension * diffusion_um2_s);
}

double binding_occupancy(double ligand_m, double kd_m) {
    return ligand_m / (kd_m + ligand_m);
}

double nernst_potential(double cout_mM, double cin_mM, double z, double temperature_k) {
    const double R = 8.314462618;
    const double F = 96485.33212;
    return (R * temperature_k / (z * F)) * std::log(cout_mM / cin_mM);
}

double michaelis_menten(double substrate, double vmax, double km) {
    return vmax * substrate / (km + substrate);
}

int main() {
    std::cout << "model,parameter,value\n";

    for (double length_um : {0.1, 1.0, 10.0, 100.0}) {
        std::cout << std::setprecision(12)
                  << "diffusion_time,length_um_" << length_um << ","
                  << diffusion_time(length_um, 10.0, 1.0) << "\n";
    }

    for (double ligand : {1.0e-9, 1.0e-8, 1.0e-7, 1.0e-6, 1.0e-5}) {
        std::cout << "binding_occupancy,ligand_" << ligand << ","
                  << binding_occupancy(ligand, 1.0e-6) << "\n";
    }

    std::cout << "nernst_potential,potassium,"
              << nernst_potential(5.0, 140.0, 1.0, 310.15) << "\n";

    for (double substrate : {1.0, 10.0, 50.0, 100.0, 500.0}) {
        std::cout << "michaelis_menten,substrate_" << substrate << ","
                  << michaelis_menten(substrate, 100.0, 50.0) << "\n";
    }

    return 0;
}
