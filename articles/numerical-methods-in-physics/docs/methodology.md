# Methodology Notes

## Purpose

This repository folder supports an article on numerical methods in physics by translating discretization, convergence, stability, conditioning, ODE solvers, PDE solvers, sparse linear algebra, eigenvalue methods, Monte Carlo estimation, and verification/validation/uncertainty concepts into reproducible computational workflows.

The goal is not to replace professional PDE solvers, multiphysics frameworks, molecular dynamics engines, finite element packages, computational fluid dynamics codes, quantum chemistry packages, or production uncertainty quantification platforms. The goal is to provide transparent scaffolding for:

- derivative approximation
- convergence order estimation
- heat-equation stability
- ODE solver comparison
- sparse Poisson problems
- quantum eigenvalue scaffolds
- Monte Carlo convergence
- numerical verification metadata
- source provenance
- reproducibility documentation

## Assumptions

The introductory workflows assume:

- simple one-dimensional teaching problems
- dimensionless variables unless specified
- smooth test functions for convergence studies
- fixed boundary values for heat-equation examples
- finite difference discretizations for core PDE examples
- small matrix systems for eigenvalue demonstrations
- Monte Carlo examples with fixed random seeds
- no production-grade adaptive mesh refinement
- no full finite element or finite volume framework

## Computational Philosophy

The code is organized by scientific role:

- Python: flexible scientific computing, sparse linear algebra, ODE/PDE examples, Monte Carlo
- R: convergence tables and reproducible error summaries
- Julia: compact numerical physics scaffolds
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for methods, assumptions, sources, and runs
- Rust: safe command-line utility
- C: low-level numerical calculations
