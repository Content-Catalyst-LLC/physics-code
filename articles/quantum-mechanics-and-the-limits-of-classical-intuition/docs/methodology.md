# Methodology Notes

## Purpose

This repository folder supports an article on quantum mechanics by translating core conceptual relations into reproducible computational workflows.

The goal is not to replace a full quantum-mechanics textbook, production quantum-chemistry software, or quantum-information simulation frameworks. The goal is to provide transparent scaffolding for:

- wavefunction sampling
- probability density normalization
- particle-in-a-box eigenstate analysis
- analytic and numerical eigenvalue comparison
- finite-difference Hamiltonian construction
- expectation values and uncertainty estimates
- measurement-style sampling from probability distributions
- reproducibility metadata

## Core Ideas

### Wavefunction and Probability

The wavefunction psi(x,t) is a complex-valued state amplitude. In position space, the probability density is:

|psi(x,t)|^2

A normalized wavefunction satisfies:

integral |psi(x,t)|^2 dx = 1

### Particle in a Box

The normalized eigenstates for an infinite square well from x=0 to x=L are:

psi_n(x) = sqrt(2/L) sin(n pi x / L)

The corresponding energies are:

E_n = n^2 pi^2 hbar^2 / (2 m L^2)

### Uncertainty

The position-momentum uncertainty relation is:

Delta x Delta p >= hbar / 2

The workflows include position uncertainty directly and provide scaffolding for finite-difference momentum uncertainty.

### Finite Difference Hamiltonian

For a one-dimensional grid, the kinetic-energy operator can be approximated with a second-derivative matrix. This converts the stationary Schrödinger equation into a matrix eigenvalue problem.

## Assumptions

The introductory workflows assume:

- one-dimensional systems
- infinite square well unless otherwise specified
- nonrelativistic quantum mechanics
- normalized wavefunctions
- illustrative grid resolution
- no spin
- no many-body effects
- no quantum-field-theoretic particle creation
- no decoherence model unless extended separately

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for full numerical quantum packages, quantum chemistry, many-body physics, or experimental quantum-data analysis.

## Computational Philosophy

The code is organized by scientific role:

- Python: numerical modeling, eigenstates, finite-difference Hamiltonians, uncertainty estimates
- R: probability summaries, measurement-style sampling, visualization-ready tabular outputs
- Julia: high-performance numerical linear algebra and Hamiltonian scaffolding
- C++: performance-oriented table generation and simulation loops
- Fortran: classic scientific-computing energy-level tables
- SQL: structured metadata for runs, states, operators, constants, and source provenance
- Rust: safe command-line utility
- C: low-level numerical table calculation
