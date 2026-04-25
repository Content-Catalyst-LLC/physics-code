# Methodology Notes

## Purpose

This repository folder supports an article on gravity, curvature, and spacetime by translating core general-relativity relations into reproducible computational workflows.

The goal is not to replace numerical relativity software, tensor algebra systems, black-hole perturbation codes, gravitational-wave inference pipelines, or cosmological Boltzmann solvers. The goal is to provide transparent scaffolding for:

- Schwarzschild radius calculation
- gravitational time-dilation factors
- weak-field and strong-field comparison
- basic relativistic parameter sweeps
- spacetime model metadata
- simple gravitational-wave strain examples
- reproducibility documentation

## Core Ideas

### Schwarzschild Radius

r_s = 2 G M / c^2

This gives the characteristic horizon scale of the simplest non-rotating black-hole geometry.

### Clock-Rate Factor

d_tau/dt = sqrt(1 - r_s/r)

This expresses the gravitational time-dilation factor for stationary clocks in Schwarzschild geometry.

### Metric Interval

ds^2 = g_mu_nu dx^mu dx^nu

This is the invariant spacetime interval in tensor notation.

### Einstein Field Equation

G_mu_nu + Lambda g_mu_nu = 8 pi G / c^4 T_mu_nu

This links spacetime curvature to stress-energy.

### Geodesic Motion

d2x^mu/dtau2 + Gamma^mu_alpha_beta dx^alpha/dtau dx^beta/dtau = 0

This describes freely falling motion in curved spacetime.

## Assumptions

The introductory workflows assume:

- Schwarzschild geometry unless otherwise specified
- non-rotating spherical mass
- stationary clocks outside the Schwarzschild radius
- no Kerr rotation
- no charge
- no full tensor symbolic computation unless extended separately
- no full numerical relativity
- no gravitational-wave parameter estimation
- no cosmological background expansion model unless added separately

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for validated numerical relativity, high-precision ephemeris modeling, gravitational-wave inference pipelines, satellite navigation systems, or professional metrology software.

## Computational Philosophy

The code is organized by scientific role:

- Python: numerical modeling, Schwarzschild functions, weak-field comparison, strain toy models
- R: parameter sweeps, summaries, visualizable tables
- Julia: high-performance numerical scaffolding and effective-potential examples
- C++: performance-oriented radius and clock-factor sweeps
- Fortran: classic scientific-computing table generation
- SQL: structured metadata for constants, spacetime models, source notes, and simulation runs
- Rust: safe command-line utility
- C: low-level numerical calculation
