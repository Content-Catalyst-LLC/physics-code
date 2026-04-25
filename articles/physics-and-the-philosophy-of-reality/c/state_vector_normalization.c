/*
State Vector Normalization

This C example normalizes a simple two-component vector and computes
Born-rule-like probabilities for the normalized amplitudes.
*/

#include <math.h>
#include <stdio.h>

int main(void) {
    double state[2] = {1.0, 1.0};
    double norm = sqrt(state[0] * state[0] + state[1] * state[1]);

    printf("basis_index,amplitude,probability\n");

    for (int i = 0; i < 2; i++) {
        state[i] = state[i] / norm;
        printf("%d,%.8f,%.8f\n", i, state[i], state[i] * state[i]);
    }

    return 0;
}
