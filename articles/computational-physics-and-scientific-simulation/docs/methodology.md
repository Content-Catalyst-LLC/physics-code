# Methodology Notes

## Purpose

This repository folder supports an article on computational physics and scientific simulation by translating numerical modeling, discretization, finite-difference methods, Monte Carlo uncertainty propagation, verification-style diagnostics, and simulation metadata into reproducible workflows.

The goal is not to replace professional simulation frameworks, production CFD codes, finite element packages, molecular dynamics engines, climate models, or high-performance computing platforms. The goal is to provide transparent scaffolding for:

- finite-difference diffusion
- ODE integration
- convergence diagnostics
- Monte Carlo uncertainty propagation
- stability checks
- simulation metadata
- unit documentation
- source provenance
- verification-style comparisons
- reproducibility documentation

## Core Ideas

### Time Integration

dx/dt = F(x,t)

x_{n+1} = Phi_dt(x_n)

### Diffusion Equation

partial u/partial t = D partial2 u/partial x2

u_i^{n+1} = u_i^n + s(u_{i+1}^n - 2u_i^n + u_{i-1}^n)

s = D dt / dx^2

### Monte Carlo

E[f(X)] approx (1/N) sum_i f(X_i)

standard error proportional to 1/sqrt(N)

### Convergence

||u - u_h|| approx C h^p

### Error Sources

total error = model error + discretization error + iteration error + roundoff error + input error

## Assumptions

The introductory workflows assume:

- SI units unless stated otherwise
- one-dimensional diffusion for finite-difference scaffolds
- explicit finite-difference time stepping for teaching clarity
- ideal projectile motion for Monte Carlo uncertainty propagation
- simple harmonic oscillator for ODE solver diagnostics
- no production PDE solver
- no parallel computing implementation
- no validated engineering design workflow
- no formal regulatory-grade VVUQ process

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for OpenFOAM, SU2, ANSYS, COMSOL, PETSc, FEniCS, MOOSE, LAMMPS, GROMACS, climate models, or mission-critical simulation environments.

## Computational Philosophy

The code is organized by scientific role:

- Python: finite differences, ODE solvers, convergence diagnostics, simulation outputs
- R: Monte Carlo uncertainty, statistical summaries, reproducible reporting
- Julia: compact numerical simulation examples
- C++: performance-oriented finite-difference loops
- Fortran: classic scientific-computing tables
- SQL: structured metadata for simulations, variables, solvers, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
