/*
Diode Conductivity Table

This C workflow computes thermal voltage, conductivity, and ideal diode current.
*/

#include <math.h>
#include <stdio.h>

double thermal_voltage(double temperature_k) {
    const double q = 1.602176634e-19;
    const double kb = 1.380649e-23;
    return kb * temperature_k / q;
}

double conductivity_s_m(double n_cm3, double mobility_cm2_v_s) {
    const double q = 1.602176634e-19;
    double n_m3 = n_cm3 * 1.0e6;
    double mobility_m2_v_s = mobility_cm2_v_s * 1.0e-4;
    return q * n_m3 * mobility_m2_v_s;
}

double diode_current(double voltage_v, double is_a, double ideality, double temperature_k) {
    double vt = thermal_voltage(temperature_k);
    double exponent = voltage_v / (ideality * vt);

    if (exponent > 100.0) {
        exponent = 100.0;
    }

    if (exponent < -100.0) {
        exponent = -100.0;
    }

    return is_a * (exp(exponent) - 1.0);
}

int main(void) {
    printf("quantity,value,unit\n");
    printf("thermal_voltage_300K,%.10f,V\n", thermal_voltage(300.0));
    printf("conductivity_1e16_1000,%.10f,S/m\n", conductivity_s_m(1.0e16, 1000.0));

    printf("voltage_v,current_a\n");

    for (int i = -2; i <= 8; i++) {
        double voltage = (double)i * 0.1;
        double current = diode_current(voltage, 1.0e-12, 1.0, 300.0);
        printf("%.4f,%.8e\n", voltage, current);
    }

    return 0;
}
