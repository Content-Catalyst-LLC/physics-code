# Methodology Notes

## Purpose

This repository folder supports an article on superconductivity, superfluidity, and macroscopic quantum order by translating order-parameter theory, Ginzburg-Landau free energy, Josephson phase dynamics, flux quantization, vortex phase fields, and simplified BCS gap behavior into reproducible computational workflows.

The goal is not to replace professional superconductivity packages, microscopic many-body solvers, Bogoliubov-de Gennes codes, quantum-device circuit simulators, ultracold-atom solvers, or validated materials workflows. The goal is to provide transparent scaffolding for:

- complex order-parameter behavior
- Ginzburg-Landau free-energy landscapes
- equilibrium amplitude below a critical temperature
- Josephson phase dynamics
- superconducting flux quantization
- superfluid vortex phase winding
- simplified BCS gap-temperature behavior
- metadata provenance
- reproducibility documentation

## Assumptions

The introductory workflows assume:

- uniform order parameter unless spatial variation is explicitly modeled
- simplified Ginzburg-Landau coefficients
- dimensionless Josephson dynamics in the article example
- idealized flux quantization with Cooper-pair charge 2e
- simplified vortex phase maps without solving full Gross-Pitaevskii dynamics
- approximate BCS gap behavior for teaching purposes
- no production superconducting-circuit or materials simulation

## Computational Philosophy

The code is organized by scientific role:

- Python: Josephson dynamics, flux quantization, vortex phases, BCS gap approximations
- R: free-energy landscapes and phase-transition summaries
- Julia: compact order-parameter calculations
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for observables, phases, materials, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
