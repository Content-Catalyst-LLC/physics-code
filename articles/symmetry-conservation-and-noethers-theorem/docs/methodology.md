# Methodology Notes

## Purpose

This repository folder supports an article on symmetry, conservation, and Noether's theorem by translating continuous symmetry, action invariance, cyclic coordinates, canonical momenta, conserved charges, field-theory currents, angular momentum conservation, and quantum generators into reproducible computational workflows.

The goal is not to replace advanced symbolic algebra systems, full field-theory packages, lattice gauge theory codes, quantum field theory software, or formal theorem-proving environments. The goal is to provide transparent scaffolding for:

- symmetry-to-conservation mapping
- conserved-charge diagnostics
- central-force angular momentum conservation
- harmonic oscillator energy conservation
- cyclic-coordinate identification
- symbolic Noether charge examples
- field-theory current examples
- quantum generator matrices
- source provenance
- reproducibility documentation

## Core Ideas

### Action Principle

S = integral L dt

### Euler-Lagrange Equation

d/dt(partial L / partial qdot_i) - partial L / partial q_i = 0

### Canonical Momentum

p_i = partial L / partial qdot_i

### Hamiltonian

H = sum_i p_i qdot_i - L

### Noether Charge

Q = sum_i p_i eta_i - H tau - F

### Field Current

j^mu = sum_a [partial L / partial(partial_mu phi_a)] Delta phi_a - K^mu

### Conservation

dQ/dt = 0

partial_mu j^mu = 0

## Assumptions

The introductory workflows assume:

- classical mechanics in low-dimensional systems
- simple conservative forces
- ideal central potentials where stated
- numerical integration as a diagnostic, not proof
- standard sign conventions for Noether charges
- symbolic workflows as teaching examples, not full variational-calculus engines
- simple field-theory examples without gauge fixing or constraints
- no full quantum field theory package
- no lattice gauge theory implementation
- no theorem-proving formalization

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for professional symbolic computation, numerical relativity, lattice field theory, Hamiltonian constraint analysis, gauge-theory quantization, or advanced algebraic quantum field theory.

## Computational Philosophy

The code is organized by scientific role:

- Python: central-force mechanics, symbolic checks, field currents, quantum generators
- R: conceptual maps and metadata summaries
- Julia: compact symmetry calculations
- C++: performance-oriented orbit sweeps
- Fortran: classic scientific-computing conservation tables
- SQL: structured metadata for symmetries, conserved quantities, relations, assumptions, and sources
- Rust: safe command-line conservation diagnostics
- C: low-level numerical calculations
