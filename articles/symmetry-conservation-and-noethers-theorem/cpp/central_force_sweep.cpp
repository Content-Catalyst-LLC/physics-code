/*
Central Force Sweep

This C++ workflow computes energy and angular momentum for sample
initial conditions in an inverse-square central potential.
*/

#include <cmath>
#include <iomanip>
#include <iostream>
#include <vector>

struct State {
    double x;
    double y;
    double vx;
    double vy;
};

double energy(double mu, const State& state) {
    double r = std::sqrt(state.x * state.x + state.y * state.y);
    double kinetic = 0.5 * (state.vx * state.vx + state.vy * state.vy);
    double potential = -mu / r;
    return kinetic + potential;
}

double angular_momentum_z(const State& state) {
    return state.x * state.vy - state.y * state.vx;
}

int main() {
    const double mu = 1.0;

    std::vector<State> states = {
        {1.0, 0.0, 0.0, 0.8},
        {1.0, 0.0, 0.0, 1.0},
        {2.0, 0.0, 0.0, 0.5},
        {1.0, 1.0, -0.3, 0.7}
    };

    std::cout << "case_id,x,y,vx,vy,energy,angular_momentum_z\n";

    for (std::size_t i = 0; i < states.size(); ++i) {
        const State& s = states[i];

        std::cout << std::setprecision(12)
                  << "case_" << i + 1 << ","
                  << s.x << ","
                  << s.y << ","
                  << s.vx << ","
                  << s.vy << ","
                  << energy(mu, s) << ","
                  << angular_momentum_z(s) << "\n";
    }

    return 0;
}
