# Symmetry, Conservation, and Noether's Theorem

This folder supports the Physics knowledge-series article **Symmetry, Conservation, and Noether's Theorem**.

The article examines invariance, transformation groups, continuous symmetry, discrete symmetry, action principles, cyclic coordinates, canonical momenta, Noether charges, conserved currents, spacetime symmetries, internal symmetries, gauge symmetries, Noether's first theorem, Noether's second theorem, symmetry breaking, quantum symmetry, field-theoretic currents, conservation laws, constraints, and computational verification.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible symmetry-analysis workflows.

## Included Materials

- Python workflows for central-force angular momentum conservation, harmonic oscillator energy conservation, symbolic Noether charge examples, field-current examples, and quantum generators
- R workflows for symmetry-to-conservation mapping and conservation-law metadata
- Julia symmetry and conservation scaffolding
- C++ central-force parameter sweeps
- Fortran conservation-law tables
- SQL metadata for symmetries, conserved quantities, physical relations, source notes, assumptions, and simulation runs
- Rust command-line utility for central-force conservation diagnostics
- C low-level conservation table examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Action:

S = integral L(q_i, qdot_i, t) dt

Euler-Lagrange equation:

d/dt(partial L / partial qdot_i) - partial L / partial q_i = 0

Canonical momentum:

p_i = partial L / partial qdot_i

Hamiltonian:

H = sum_i p_i qdot_i - L

Noether charge:

Q = sum_i p_i eta_i - H tau - F

Conservation:

dQ/dt = 0

Field-theory current:

j^mu = sum_a [partial L / partial(partial_mu phi_a)] Delta phi_a - K^mu

Current conservation:

partial_mu j^mu = 0

Angular momentum:

L = r x p

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/symmetry-conservation-and-noethers-theorem
