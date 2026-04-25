/*
Helium-4 Binding Energy

This C workflow computes a schematic helium-4 binding energy:

    delta_m = 2*m_p + 2*m_n - m_He4
    B = delta_m * 931.49410242 MeV

The values are approximate educational values.
*/

#include <stdio.h>

int main(void) {
    const double proton_mass_u = 1.007276466621;
    const double neutron_mass_u = 1.00866491595;
    const double helium4_nuclear_mass_u = 4.001506179127;
    const double u_to_mev = 931.49410242;

    double free_nucleon_mass_u = 2.0 * proton_mass_u + 2.0 * neutron_mass_u;
    double mass_defect_u = free_nucleon_mass_u - helium4_nuclear_mass_u;
    double binding_energy_mev = mass_defect_u * u_to_mev;
    double binding_energy_per_nucleon_mev = binding_energy_mev / 4.0;

    printf("free_nucleon_mass_u,helium4_nuclear_mass_u,mass_defect_u,binding_energy_mev,binding_energy_per_nucleon_mev\n");
    printf("%.12f,%.12f,%.12f,%.8f,%.8f\n",
           free_nucleon_mass_u,
           helium4_nuclear_mass_u,
           mass_defect_u,
           binding_energy_mev,
           binding_energy_per_nucleon_mev);

    return 0;
}
