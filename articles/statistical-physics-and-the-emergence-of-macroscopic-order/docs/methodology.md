# Methodology Notes

## Purpose

This repository folder supports an article on statistical physics by translating core probabilistic and thermodynamic relations into reproducible computational workflows.

The goal is not to replace molecular dynamics packages, professional Monte Carlo engines, statistical thermodynamics databases, phase-transition research codes, or quantum many-body solvers. The goal is to provide transparent scaffolding for:

- exact two-state macrostate distributions
- Boltzmann weighting
- partition-function calculation
- Monte Carlo sampling
- fluctuation scaling
- finite-size effects
- Ising-style order-parameter scaffolding
- ensemble metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Boltzmann Entropy

S = k_B ln W

### Canonical Probability

P_i = exp(-beta E_i) / Z

### Partition Function

Z = sum_i exp(-beta E_i)

### Two-State Model

Z = 1 + exp(-beta epsilon)

P_exc = exp(-beta epsilon) / [1 + exp(-beta epsilon)]

For N independent constituents:

W(n) = N! / [n!(N-n)!]

P(n) is proportional to W(n) exp(-beta n epsilon).

### Fluctuation Scaling

For independent two-state systems, relative fluctuations shrink with system size, helping explain the emergence of stable macroscopic behavior.

## Assumptions

The introductory workflows assume:

- independent two-state constituents unless otherwise specified
- canonical ensemble temperature control
- no interactions in the main two-state examples
- idealized Ising-style lattice scaffolding for collective behavior
- no continuum limit unless extended separately
- no molecular dynamics
- no quantum indistinguishability in the introductory model
- no real material calibration
- no production thermochemistry workflow

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for validated materials-simulation codes, quantum many-body methods, computational chemistry packages, or experimentally calibrated statistical thermodynamics databases.

## Computational Philosophy

The code is organized by scientific role:

- Python: exact distributions, partition functions, Monte Carlo sampling, lattice scaffolds
- R: distribution summaries, fluctuation scaling, visualization-ready outputs
- Julia: high-performance lattice and Monte Carlo scaffolding
- C++: exact enumeration and parameter sweeps
- Fortran: classic scientific-computing thermodynamic tables
- SQL: structured metadata for ensembles, state models, constants, assumptions, and source provenance
- Rust: safe command-line utility
- C: low-level partition-function table calculation
