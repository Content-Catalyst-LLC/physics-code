# Methodology Notes

## Purpose

This repository folder supports an article on path integrals and functional methods by translating discretized Euclidean actions, Monte Carlo path sampling, Gaussian integral diagnostics, generating functionals, lattice scalar fields, stochastic paths, and metadata provenance into reproducible computational workflows.

The goal is not to replace professional lattice field theory software, symbolic QFT packages, quantum chemistry systems, tensor-network systems, stochastic calculus libraries, or high-performance Monte Carlo production codes. The goal is to provide transparent scaffolding for:

- discretized path actions
- Euclidean harmonic oscillator paths
- Metropolis path sampling
- Gaussian integral diagnostics
- generating-functional derivatives
- correlation-function estimation
- lattice scalar-field scaffolds
- stochastic path examples
- source provenance
- reproducibility documentation

## Core Ideas

### Action

S[q] = integral L(q, qdot, t) dt

### Path Integral

K = integral Dq exp(i S[q]/hbar)

### Euclidean Path Integral

Z = integral Dq exp(-S_E[q]/hbar)

### Gaussian Integral

Integral dx exp(-1/2 x^T A x + J^T x) = sqrt((2pi)^n/det A) exp(1/2 J^T A^-1 J)

### Generating Functional

Z[J] = integral Dphi exp((i/hbar)(S[phi] + integral J phi))

### Discretized Euclidean Oscillator

S_E = sum_n [m/(2 Delta tau)(x[n+1]-x[n])^2 + Delta tau/2 m omega^2 x[n]^2]

## Assumptions

The introductory workflows assume:

- hbar = 1 unless otherwise specified
- Euclidean time rather than real-time oscillatory integration for numerical sampling
- periodic imaginary-time boundary conditions in oscillator examples
- local Metropolis updates for teaching-scale Monte Carlo
- simple harmonic oscillator action for path examples
- scalar-field scaffolding rather than production lattice field theory
- finite-dimensional Gaussian diagnostics
- no gauge fixing or Grassmann algebra implementation unless extended

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for production lattice QCD codes, professional Monte Carlo packages, dedicated QFT symbolic systems, validated stochastic-process packages, or mathematically rigorous path-integral constructions.

## Computational Philosophy

The code is organized by scientific role:

- Python: Monte Carlo sampling, path actions, Gaussian diagnostics, generating functionals, lattice scalar fields
- R: path-action summaries and reproducible tables
- Julia: compact path-integral calculations
- C++: performance-oriented action sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for actions, discretization, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
