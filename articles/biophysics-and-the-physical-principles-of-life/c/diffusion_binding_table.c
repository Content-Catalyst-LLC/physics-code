/*
Diffusion and Binding Table

This C workflow computes diffusion time, binding occupancy,
Nernst potential, and Michaelis-Menten rate.
*/

#include <math.h>
#include <stdio.h>

double diffusion_time(double length_um, double diffusion_um2_s, double dimension) {
    return pow(length_um, 2.0) / (2.0 * dimension * diffusion_um2_s);
}

double binding_occupancy(double ligand_m, double kd_m) {
    return ligand_m / (kd_m + ligand_m);
}

double nernst_potential(double cout_mM, double cin_mM, double z, double temperature_k) {
    const double gas_constant = 8.314462618;
    const double faraday_constant = 96485.33212;
    return (gas_constant * temperature_k / (z * faraday_constant)) * log(cout_mM / cin_mM);
}

double michaelis_menten(double substrate, double vmax, double km) {
    return vmax * substrate / (km + substrate);
}

int main(void) {
    printf("quantity,value,unit\n");
    printf("diffusion_time_cell,%.8f,s\n", diffusion_time(10.0, 10.0, 1.0));
    printf("binding_occupancy_at_KD,%.8f,dimensionless\n", binding_occupancy(1.0e-6, 1.0e-6));
    printf("potassium_nernst_310K,%.8f,V\n", nernst_potential(5.0, 140.0, 1.0, 310.15));
    printf("enzyme_rate_at_KM,%.8f,uM/s\n", michaelis_menten(50.0, 100.0, 50.0));

    return 0;
}
