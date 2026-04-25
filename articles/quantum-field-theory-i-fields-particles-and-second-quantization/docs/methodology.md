# Methodology Notes

## Purpose

This repository folder supports an article on quantum field theory, fields, particles, and second quantization by translating Fock states, creation and annihilation operators, scalar-field modes, propagators, occupation-number systems, Wick-style contractions, and fermionic anticommutation into reproducible computational workflows.

The goal is not to replace professional symbolic QFT packages, lattice QFT software, high-energy event generators, functional integral packages, renormalization-group engines, or many-body quantum simulation libraries. The goal is to provide transparent scaffolding for:

- creation and annihilation operators
- truncated Fock-space matrices
- number operator diagnostics
- harmonic oscillator Hamiltonians
- scalar-field dispersion relations
- momentum-space propagator grids
- bosonic occupation numbers
- fermionic anticommutation examples
- Wick-style contraction metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Harmonic Oscillator

H = hbar omega (a dagger a + 1/2)

### Ladder Operators

a |n> = sqrt(n) |n-1>

a dagger |n> = sqrt(n+1) |n+1>

### Number Operator

N = a dagger a

### Scalar Field

L = 1/2 partial_mu phi partial^mu phi - 1/2 m^2 phi^2

### Canonical Quantization

[phi(x,t), pi(y,t)] = i hbar delta^3(x-y)

### Propagator

Delta_F(p) = i/(p^2 - m^2 + i epsilon)

### Bose Occupation

n_bar = 1/(exp(beta hbar omega)-1)

## Assumptions

The introductory workflows assume:

- finite Fock-space truncations for matrix representations
- natural units in many examples unless explicitly stated
- free-field scalar modes for dispersion examples
- simplified propagator expressions without contour integration
- educational Wick-contraction metadata rather than full symbolic contraction engines
- fermionic anticommutation examples in finite matrix systems
- no full interacting QFT calculation
- no loop-integral regularization or renormalization engine
- no lattice gauge theory
- no high-energy event simulation

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for FeynCalc, FORM, FeynArts, MadGraph, PySCF many-body tools, TeNPy, ITensor, QuTiP, lattice QCD codes, perturbative QFT packages, or validated research pipelines.

## Computational Philosophy

The code is organized by scientific role:

- Python: operator matrices, propagator grids, symbolic metadata, fermionic algebra examples
- R: occupation-number sweeps and reproducible summaries
- Julia: compact QFT calculations
- C++: performance-oriented Fock-space sweeps
- Fortran: classic scientific-computing mode tables
- SQL: structured metadata for fields, operators, relations, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
