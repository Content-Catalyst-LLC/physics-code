/*
Orbit Velocity-Verlet Simulation

This C++ workflow demonstrates a performance-oriented integration loop
for a simplified Newtonian two-body orbital problem in dimensionless units.

Equation:
    r'' = -mu * r / |r|^3

The velocity-Verlet method is common in computational mechanics because
it often behaves well for conservative systems.
*/

#include <cmath>
#include <iomanip>
#include <iostream>

struct State {
    double x;
    double y;
    double vx;
    double vy;
};

void acceleration(double x, double y, double mu, double& ax, double& ay) {
    const double radius = std::sqrt(x * x + y * y);
    const double factor = -mu / (radius * radius * radius);

    ax = factor * x;
    ay = factor * y;
}

int main() {
    const double mu = 1.0;
    const double dt = 0.001;
    const double total_time = 10.0;
    const int steps = static_cast<int>(total_time / dt);

    State state{1.0, 0.0, 0.0, 1.0};

    double ax = 0.0;
    double ay = 0.0;
    acceleration(state.x, state.y, mu, ax, ay);

    std::cout << "time,x,y,vx,vy,energy_like_quantity\n";

    for (int step = 0; step <= steps; ++step) {
        const double time = step * dt;
        const double radius = std::sqrt(state.x * state.x + state.y * state.y);
        const double kinetic = 0.5 * (state.vx * state.vx + state.vy * state.vy);
        const double potential = -mu / radius;
        const double energy = kinetic + potential;

        if (step % 100 == 0) {
            std::cout << std::fixed << std::setprecision(8)
                      << time << ","
                      << state.x << ","
                      << state.y << ","
                      << state.vx << ","
                      << state.vy << ","
                      << energy << "\n";
        }

        state.x += state.vx * dt + 0.5 * ax * dt * dt;
        state.y += state.vy * dt + 0.5 * ay * dt * dt;

        double next_ax = 0.0;
        double next_ay = 0.0;
        acceleration(state.x, state.y, mu, next_ax, next_ay);

        state.vx += 0.5 * (ax + next_ax) * dt;
        state.vy += 0.5 * (ay + next_ay) * dt;

        ax = next_ax;
        ay = next_ay;
    }

    return 0;
}
