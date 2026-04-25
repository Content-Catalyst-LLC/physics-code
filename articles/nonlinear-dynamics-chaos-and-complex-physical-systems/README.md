# Nonlinear Dynamics, Chaos, and Complex Physical Systems

This folder supports the Physics knowledge-series article **Nonlinear Dynamics, Chaos, and Complex Physical Systems**.

The article examines nonlinear equations, phase space, fixed points, stability, bifurcations, limit cycles, chaos, sensitive dependence, the logistic map, the Lorenz system, strange attractors, Lyapunov exponents, fractals, intermittency, synchronization, pattern formation, turbulence, complex physical systems, and computational nonlinear dynamics.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible nonlinear-dynamics workflows.

## Included Materials

- Python workflows for Lorenz integration, trajectory separation, Lyapunov-style diagnostics, phase portraits, logistic maps, and fixed-point stability
- R workflows for logistic-map bifurcation summaries, parameter sweeps, and long-run state diagnostics
- Julia nonlinear-systems scaffolding
- C++ logistic-map parameter sweeps
- Fortran Lorenz trajectory tables
- SQL metadata for nonlinear systems, parameters, attractors, bifurcations, sources, assumptions, and simulation runs
- Rust command-line utility for logistic-map iteration
- C low-level logistic-map table example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Continuous dynamical system:

dx/dt = F(x, mu)

Fixed point:

F(x*, mu) = 0

Jacobian:

J_ij = partial F_i / partial x_j

Discrete map:

x_{n+1} = f(x_n)

Map fixed point:

x* = f(x*)

One-dimensional map stability:

|f'(x*)| < 1

Logistic map:

x_{n+1} = r x_n (1 - x_n)

Lorenz system:

dx/dt = sigma(y - x)

dy/dt = x(rho - z) - y

dz/dt = xy - beta z

Separation growth:

|delta(t)| approx |delta(0)| exp(lambda t)

Lyapunov exponent:

lambda approx lim_{t->infinity} (1/t) ln(|delta(t)|/|delta(0)|)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/nonlinear-dynamics-chaos-and-complex-physical-systems
