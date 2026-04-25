# Methodology Notes

## Purpose

This repository folder supports an article on Lagrangian and Hamiltonian mechanics by translating action principles, phase-space dynamics, symplectic integration, Poisson brackets, and normal-mode analysis into reproducible computational workflows.

The goal is not to replace advanced symbolic mechanics systems, professional celestial mechanics packages, geometric mechanics libraries, or high-precision dynamical simulation platforms. The goal is to provide transparent scaffolding for:

- Lagrangian and Hamiltonian formulation
- pendulum dynamics
- phase-space diagnostics
- energy conservation and energy drift
- symplectic Euler integration
- ordinary explicit Euler comparison
- Poisson bracket calculations
- normal-mode eigenvalue problems
- analytical-mechanics metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Lagrangian Mechanics

L = T - V

S = integral L dt

delta S = 0

d/dt(partial L / partial qdot_i) - partial L / partial q_i = 0

### Hamiltonian Mechanics

p_i = partial L / partial qdot_i

H = sum_i p_i qdot_i - L

qdot_i = partial H / partial p_i

pdot_i = -partial H / partial q_i

### Poisson Brackets

{A,B} = sum_i(partial A/partial q_i partial B/partial p_i - partial A/partial p_i partial B/partial q_i)

dA/dt = {A,H} + partial A/partial t

### Pendulum Hamiltonian

H(theta,p) = p^2/(2 m l^2) + m g l(1 - cos theta)

### Normal Modes

M qddot + K q = 0

(K - omega^2 M)a = 0

## Assumptions

The introductory workflows assume:

- classical mechanics
- conservative Hamiltonian systems unless otherwise stated
- SI units
- simple pendulum with fixed length and no damping for core Hamiltonian examples
- symplectic Euler as a transparent introductory symplectic method
- small-oscillation assumptions in normal-mode examples
- no relativistic mechanics in introductory scripts
- no constrained Dirac mechanics
- no advanced symplectic manifold implementation
- no production celestial or molecular dynamics software

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for professional dynamics packages, geometric mechanics frameworks, high-order symplectic integrators, molecular dynamics engines, or validated orbital propagation systems.

## Computational Philosophy

The code is organized by scientific role:

- Python: phase-space integration, symplectic methods, energy drift, Poisson brackets, normal modes
- R: phase-space tables, Hamiltonian energy grids, summary statistics
- Julia: compact high-performance Hamiltonian scaffolding
- C++: performance-oriented symplectic integration
- Fortran: classic scientific-computing Hamiltonian tables
- SQL: structured metadata for coordinates, Hamiltonians, constraints, symmetries, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
