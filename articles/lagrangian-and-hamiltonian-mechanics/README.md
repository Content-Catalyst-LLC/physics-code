# Lagrangian and Hamiltonian Mechanics

This folder supports the Physics knowledge-series article **Lagrangian and Hamiltonian Mechanics**.

The article examines generalized coordinates, degrees of freedom, constraints, the Lagrangian, stationary action, Euler-Lagrange equations, canonical momentum, cyclic coordinates, symmetry and conservation, Noether's theorem, the Hamiltonian, Hamilton's equations, phase space, Poisson brackets, canonical transformations, small oscillations, normal modes, and computational mechanics.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible analytical-mechanics workflows.

## Included Materials

- Python workflows for Hamiltonian pendulum integration, symplectic Euler methods, energy drift, Poisson brackets, and normal-mode scaffolds
- R workflows for pendulum phase-space energy surfaces, Hamiltonian summaries, and oscillator-mode tables
- Julia Hamiltonian-system scaffolding
- C++ symplectic integrator and phase-space parameter sweeps
- Fortran oscillator and Hamiltonian tables
- SQL metadata for coordinates, Lagrangians, Hamiltonians, constraints, symmetries, sources, assumptions, and simulation runs
- Rust command-line utility for Hamiltonian pendulum diagnostics
- C low-level Hamiltonian table example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Lagrangian:

L = T - V

Action:

S[q] = integral L(q, qdot, t) dt

Stationary action:

delta S = 0

Euler-Lagrange equations:

d/dt(partial L / partial qdot_i) - partial L / partial q_i = 0

Canonical momentum:

p_i = partial L / partial qdot_i

Hamiltonian:

H(q,p,t) = sum_i p_i qdot_i - L

Hamilton's equations:

qdot_i = partial H / partial p_i

pdot_i = -partial H / partial q_i

Poisson bracket:

{A,B} = sum_i(partial A/partial q_i partial B/partial p_i - partial A/partial p_i partial B/partial q_i)

Time evolution:

dA/dt = {A,H} + partial A/partial t

Simple pendulum Hamiltonian:

H(theta,p) = p^2/(2 m l^2) + m g l(1 - cos theta)

Normal modes:

(K - omega^2 M)a = 0

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/lagrangian-and-hamiltonian-mechanics
