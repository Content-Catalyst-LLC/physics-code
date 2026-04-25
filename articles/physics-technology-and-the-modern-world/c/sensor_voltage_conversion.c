/*
Sensor Voltage Conversion

This C example models a low-level instrumentation-style conversion:

    measured_quantity = scale_factor * voltage + offset

This pattern appears in many sensor systems after calibration.
*/

#include <stdio.h>

double convert_voltage_to_quantity(double voltage_v, double scale_factor, double offset) {
    return scale_factor * voltage_v + offset;
}

int main(void) {
    const double scale_factor_units_per_v = 100.0;
    const double offset_units = 0.0;
    const double voltages_v[] = {0.25, 0.50, 0.75, 1.00, 1.25};
    const int n_samples = 5;

    printf("sample_id,voltage_v,converted_quantity\n");

    for (int i = 0; i < n_samples; i++) {
        double converted_quantity = convert_voltage_to_quantity(
            voltages_v[i],
            scale_factor_units_per_v,
            offset_units
        );

        printf("%d,%.6f,%.6f\n", i + 1, voltages_v[i], converted_quantity);
    }

    return 0;
}
