# Methodology Notes

## Purpose

This repository folder supports an article on nonlinear dynamics, chaos, and complex physical systems by translating fixed-point stability, bifurcation analysis, logistic-map iteration, Lorenz integration, trajectory separation, and Lyapunov-style diagnostics into reproducible computational workflows.

The goal is not to replace professional nonlinear dynamics software, rigorous chaos-analysis packages, atmospheric models, turbulence solvers, or full complex systems platforms. The goal is to provide transparent scaffolding for:

- nonlinear map iteration
- bifurcation diagrams
- long-run state summaries
- fixed-point stability
- Lorenz system integration
- trajectory separation diagnostics
- Lyapunov-style estimates
- phase-space outputs
- attractor metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Continuous Systems

dx/dt = F(x, mu)

F(x*, mu) = 0

J_ij = partial F_i / partial x_j

### Discrete Maps

x_{n+1} = f(x_n)

x* = f(x*)

|f'(x*)| < 1

### Logistic Map

x_{n+1} = r x_n(1 - x_n)

### Lorenz System

dx/dt = sigma(y - x)

dy/dt = x(rho - z) - y

dz/dt = xy - beta z

### Sensitive Dependence

|delta(t)| approx |delta(0)| exp(lambda t)

lambda approx lim (1/t) ln(|delta(t)|/|delta(0)|)

## Assumptions

The introductory workflows assume:

- deterministic dynamical systems
- dimensionless logistic-map variables
- common Lorenz parameters sigma = 10, rho = 28, beta = 8/3
- numerical integration with explicit tolerances
- trajectory-separation diagnostics as illustrative rather than rigorous full-spectrum Lyapunov estimation
- simplified qualitative region labels for logistic-map parameter ranges
- no production atmospheric modeling
- no turbulence closure modeling
- no formal invariant-measure estimation
- no rigorous fractal-dimension estimator in the introductory scripts

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for specialized nonlinear time-series analysis, validated physical forecasts, advanced chaos quantification, turbulence simulation, or professional complex systems platforms.

## Computational Philosophy

The code is organized by scientific role:

- Python: ODE integration, Lorenz systems, trajectory separation, fixed-point stability, Lyapunov-style diagnostics
- R: parameter sweeps, bifurcation summaries, long-run state diagnostics
- Julia: compact nonlinear systems examples
- C++: performance-oriented map sweeps
- Fortran: classic scientific-computing trajectory tables
- SQL: structured metadata for systems, parameters, attractors, bifurcations, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical iteration
