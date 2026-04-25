# Computational Physics and Scientific Simulation

This folder supports the Physics knowledge-series article **Computational Physics and Scientific Simulation**.

The article examines computational modeling, numerical approximation, discretization, floating-point arithmetic, ordinary differential equation solvers, partial differential equation methods, finite difference methods, finite element and finite volume ideas, Monte Carlo simulation, molecular dynamics, particle methods, verification, validation, uncertainty quantification, reproducibility, high-performance computing, visualization, and scientific software practice.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible computational-physics workflows.

## Included Materials

- Python workflows for finite-difference diffusion, ODE integration, convergence diagnostics, Monte Carlo uncertainty, and verification-style comparisons
- R workflows for Monte Carlo uncertainty propagation, simulation summaries, and convergence tables
- Julia numerical-simulation scaffolding
- C++ performance-oriented finite-difference loops
- Fortran scientific-computing simulation tables
- SQL metadata for simulations, variables, units, solvers, assumptions, sources, and run provenance
- Rust command-line utility for simulation diagnostics
- C low-level finite-difference example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

ODE system:

dx/dt = F(x,t)

Numerical time update:

x_{n+1} = Phi_dt(x_n)

Diffusion equation:

partial u/partial t = D partial2 u/partial x2

Finite-difference second derivative:

d2u/dx2 approx (u_{i+1} - 2u_i + u_{i-1}) / dx^2

Explicit diffusion update:

u_i^{n+1} = u_i^n + s(u_{i+1}^n - 2u_i^n + u_{i-1}^n)

Diffusion stability number:

s = D dt / dx^2

Monte Carlo expectation:

E[f(X)] approx (1/N) sum_i f(X_i)

Monte Carlo standard error scaling:

standard error proportional to 1/sqrt(N)

Convergence scaling:

||u - u_h|| approx C h^p

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/computational-physics-and-scientific-simulation
