# Methodology Notes

## Purpose

This repository folder supports an article on many-body physics and emergent collective behavior by translating Hilbert-space growth, quantum occupation statistics, exact diagonalization, spin-chain spectra, correlation functions, entanglement entropy, structure factors, and many-body metadata into reproducible computational workflows.

The goal is not to replace professional condensed-matter packages, tensor-network libraries, quantum Monte Carlo codes, density functional theory systems, dynamical mean-field theory frameworks, or validated quantum chemistry pipelines. The goal is to provide transparent scaffolding for:

- Hilbert-space scaling
- Bose and Fermi occupation statistics
- small exact diagonalization
- transverse-field Ising spectra
- connected correlation functions
- entanglement entropy
- static structure factors
- Hubbard and Heisenberg model metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Many-Body Hamiltonian

H = sum_i h_i + sum_i<j V_ij

### Hilbert-Space Growth

dim H = 2^N

### Fermi-Dirac Occupation

f(E) = 1/(exp((E - mu)/(k_B T)) + 1)

### Bose-Einstein Occupation

n(E) = 1/(exp((E - mu)/(k_B T)) - 1)

### Hubbard Model

H = -t sum_<i,j>,sigma (c_i_sigma dagger c_j_sigma + h.c.) + U sum_i n_i_up n_i_down

### Heisenberg Model

H = J sum_<i,j> S_i dot S_j

### Connected Correlation

C_ij = <O_i O_j> - <O_i><O_j>

### Entanglement Entropy

S_A = -Tr(rho_A ln rho_A)

## Assumptions

The introductory workflows assume:

- small finite systems for exact diagonalization
- dense matrices only for teaching-scale spin chains
- spin-1/2 local Hilbert spaces where specified
- periodic boundary conditions where specified
- ideal Bose and Fermi distributions for occupation examples
- simplified correlation and structure-factor scaffolds
- no production tensor-network or quantum Monte Carlo implementation
- no full Hubbard-model solver unless extended

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for ITensor, TeNPy, ALPS, TRIQS, Quantum ESPRESSO, Kwant, QuSpin, NetKet, DMRG production codes, quantum Monte Carlo solvers, or validated condensed-matter research pipelines.

## Computational Philosophy

The code is organized by scientific role:

- Python: exact diagonalization, Hilbert scaling, correlations, entanglement, structure factors
- R: occupation statistics and scaling summaries
- Julia: compact many-body calculations
- C++: performance-oriented spin-chain sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for models, phases, operators, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
