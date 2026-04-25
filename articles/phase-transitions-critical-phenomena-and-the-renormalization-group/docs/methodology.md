# Methodology Notes

## Purpose

This repository folder supports an article on phase transitions, critical phenomena, and the renormalization group by translating Landau theory, Ising-model simulation, correlation functions, critical exponents, finite-size scaling, Binder cumulants, and RG toy flows into reproducible computational workflows.

The goal is not to replace professional statistical-physics simulation packages, advanced Monte Carlo libraries, tensor-network systems, lattice field theory codes, or validated materials-science pipelines. The goal is to provide transparent scaffolding for:

- Landau free-energy landscapes
- equilibrium order-parameter extraction
- Ising-model Monte Carlo simulation
- magnetization, energy, heat capacity, and susceptibility
- Binder cumulants
- finite-size scaling
- correlation-function diagnostics
- critical-exponent fitting
- renormalization-group toy maps
- source provenance
- reproducibility documentation

## Core Ideas

### Partition Function

Z = sum exp(-beta H)

### Free Energy

F = -k_B T ln Z

### Ising Hamiltonian

H = -J sum_<i,j> s_i s_j - h sum_i s_i

### Magnetization

m = (1/N) sum_i s_i

### Correlation Length

xi ~ |t|^-nu

### Susceptibility

chi ~ |t|^-gamma

### Landau Free Energy

f(m) = f0 + a(T - Tc)m^2 + b m^4

### RG Linearization

u_i' = b^y_i u_i

## Assumptions

The introductory workflows assume:

- square-lattice Ising systems where used
- periodic boundary conditions in Ising simulations
- dimensionless coupling and temperature conventions
- Metropolis updates rather than cluster algorithms
- finite lattice sizes and finite sampling
- simple Landau mean-field free energy
- educational finite-size scaling forms
- toy RG flows rather than full field-theoretic RG
- no production-grade error analysis unless extended

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for high-performance Monte Carlo production codes, Wolff or Swendsen-Wang cluster algorithms, tensor network methods, conformal bootstrap tools, field-theoretic epsilon expansion packages, or validated experimental critical-exponent pipelines.

## Computational Philosophy

The code is organized by scientific role:

- Python: Monte Carlo simulation, Binder cumulants, finite-size scaling, correlations, RG toy maps
- R: Landau landscapes, scaling tables, reproducible summaries
- Julia: compact critical-phenomena calculations
- C++: performance-oriented Ising sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for models, exponents, universality classes, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
