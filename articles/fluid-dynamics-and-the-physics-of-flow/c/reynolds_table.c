/*
Reynolds Number Table

This C workflow computes:

    Re = rho * v * L / mu
*/

#include <stdio.h>

const char* classify_reynolds(double re) {
    if (re < 2300.0) {
        return "laminar";
    }
    if (re <= 4000.0) {
        return "transitional";
    }
    return "turbulent";
}

int main(void) {
    const char* case_ids[] = {
        "slow_water_small_pipe",
        "moderate_water_pipe",
        "fast_water_pipe",
        "viscous_oil_pipe",
        "microfluidic_channel"
    };

    double rho[] = {1000.0, 1000.0, 1000.0, 850.0, 1000.0};
    double velocity[] = {0.02, 0.50, 2.00, 0.20, 0.001};
    double length[] = {0.01, 0.05, 0.10, 0.04, 0.0001};
    double viscosity[] = {1.0e-3, 1.0e-3, 1.0e-3, 0.20, 1.0e-3};

    int n = sizeof(rho) / sizeof(rho[0]);

    printf("case_id,density_kg_per_m3,velocity_m_per_s,length_m,viscosity_pa_s,reynolds_number,flow_regime\n");

    for (int i = 0; i < n; i++) {
        double re = rho[i] * velocity[i] * length[i] / viscosity[i];

        printf("%s,%.8f,%.8f,%.10f,%.10f,%.8f,%s\n",
               case_ids[i],
               rho[i],
               velocity[i],
               length[i],
               viscosity[i],
               re,
               classify_reynolds(re));
    }

    return 0;
}
