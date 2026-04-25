# Quantum Field Theory I: Fields, Particles, and Second Quantization

This folder supports the Physics knowledge-series article **Quantum Field Theory I: Fields, Particles, and Second Quantization**.

The article examines why relativistic quantum theory requires fields, how classical fields become quantum fields, how harmonic-oscillator quantization leads to creation and annihilation operators, how Fock space organizes particle states, how scalar fields are quantized, how commutation relations encode bosonic statistics, how propagators describe amplitude flow, how interactions produce scattering, how diagrams summarize perturbation theory, how renormalization enters as a scale problem, and how QFT connects particle physics, condensed matter, statistical physics, and modern field theory.

## Repository Purpose

This folder provides advanced computational scaffolding for extending the article's selected examples into reproducible quantum-field-theory workflows.

## Included Materials

- Python workflows for Fock-space ladder operators, scalar-field dispersion, propagator grids, Wick-style contraction metadata, and fermionic anticommutation examples
- R workflows for Bose occupation, Fock-state summaries, and mode-scale tables
- Julia QFT calculation scaffolding
- C++ Fock-space parameter sweeps
- Fortran mode occupation tables
- SQL metadata for fields, operators, commutators, propagators, assumptions, sources, and simulation runs
- Rust command-line utility for oscillator and occupation calculations
- C low-level ladder and occupation examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Harmonic oscillator Hamiltonian:

H = hbar omega (a dagger a + 1/2)

Commutator:

[a, a dagger] = 1

Number operator:

N = a dagger a

Scalar field Lagrangian density:

L = 1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2

Klein-Gordon equation:

(Box + m^2) phi = 0

Canonical field commutator:

[phi(x,t), pi(y,t)] = i hbar delta^3(x-y)

Feynman propagator:

Delta_F(x-y) = <0|T{phi(x)phi(y)}|0>

Momentum-space scalar propagator:

i/(p^2 - m^2 + i epsilon)

Bose occupation:

n_bar = 1/(exp(beta hbar omega)-1)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/quantum-field-theory-i-fields-particles-and-second-quantization
