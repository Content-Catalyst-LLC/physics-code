# Methodology Notes

## Purpose

This repository folder supports an article on nonequilibrium statistical mechanics by translating Markov processes, entropy production, Langevin dynamics, Fokker-Planck relaxation, Green-Kubo estimates, fluctuation-dissipation logic, and fluctuation-theorem checks into reproducible computational workflows.

The goal is not to replace professional molecular dynamics packages, stochastic thermodynamics libraries, kinetic Monte Carlo engines, hydrodynamic solvers, Boltzmann equation solvers, or nonequilibrium field-theory tools. The goal is to provide transparent scaffolding for:

- Markov jump processes
- stationary distributions
- probability currents
- entropy production
- overdamped Langevin simulation
- Fokker-Planck relaxation
- diffusion and mobility
- Green-Kubo estimates
- fluctuation theorem checks
- stochastic thermodynamic metadata
- source provenance
- reproducibility documentation

## Assumptions

The introductory workflows assume:

- small finite-state Markov chains
- dimensionless rates unless specified
- \(k_B = 1\) in entropy-production examples unless specified
- overdamped Langevin dynamics for Brownian motion examples
- Euler-Maruyama time stepping
- harmonic potentials for equilibrium checks
- simplified stochastic trajectories for teaching purposes
- no production molecular dynamics or hydrodynamic solver

## Computational Philosophy

The code is organized by scientific role:

- Python: stochastic trajectories, Fokker-Planck scaffolds, Green-Kubo estimates, fluctuation theorem checks
- R: Markov jump processes and entropy production tables
- Julia: compact stochastic-process calculations
- C++: performance-oriented trajectory simulation
- Fortran: classic diffusion tables
- SQL: structured metadata for rates, forces, fluxes, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
