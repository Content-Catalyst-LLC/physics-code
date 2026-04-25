/*
Conservation Table

This C workflow computes energy and angular momentum for sample
central-force states.
*/

#include <math.h>
#include <stdio.h>

double energy(double mu, double x, double y, double vx, double vy) {
    double r = sqrt(x * x + y * y);
    double kinetic = 0.5 * (vx * vx + vy * vy);
    double potential = -mu / r;
    return kinetic + potential;
}

double angular_momentum_z(double x, double y, double vx, double vy) {
    return x * vy - y * vx;
}

int main(void) {
    const double mu = 1.0;

    double states[4][4] = {
        {1.0, 0.0, 0.0, 0.8},
        {1.0, 0.0, 0.0, 1.0},
        {2.0, 0.0, 0.0, 0.5},
        {1.0, 1.0, -0.3, 0.7}
    };

    printf("case_id,x,y,vx,vy,energy,angular_momentum_z\n");

    for (int i = 0; i < 4; i++) {
        double x = states[i][0];
        double y = states[i][1];
        double vx = states[i][2];
        double vy = states[i][3];

        printf("case_%d,%.8f,%.8f,%.8f,%.8f,%.12f,%.12f\n",
               i + 1,
               x,
               y,
               vx,
               vy,
               energy(mu, x, y, vx, vy),
               angular_momentum_z(x, y, vx, vy));
    }

    return 0;
}
