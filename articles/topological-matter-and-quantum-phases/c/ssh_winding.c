/*
SSH Winding Label

This C scaffold labels SSH cases using the clean-limit criterion |t2| > |t1|.
*/

#include <math.h>
#include <stdio.h>

const char* ssh_phase(double t1, double t2) {
    if (fabs(t2) > fabs(t1)) {
        return "topological_scaffold";
    }

    if (fabs(fabs(t2) - fabs(t1)) < 1e-12) {
        return "transition_scaffold";
    }

    return "trivial_scaffold";
}

int main(void) {
    double t1_values[] = {1.0, 1.0, 1.0, 0.3, 1.5};
    double t2_values[] = {0.5, 1.5, 1.0, 1.5, 0.3};
    int n = sizeof(t1_values) / sizeof(t1_values[0]);

    printf("t1,t2,phase_label\n");

    for (int i = 0; i < n; i++) {
        printf("%.6f,%.6f,%s\n", t1_values[i], t2_values[i], ssh_phase(t1_values[i], t2_values[i]));
    }

    return 0;
}
