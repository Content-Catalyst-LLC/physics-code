# Methodology Notes

## Purpose

This repository folder supports an article on topological matter and quantum phases by translating Berry phase, winding number, Chern number, band topology, edge-state scaffolds, topological superconducting chains, and metadata provenance into reproducible computational workflows.

The goal is not to replace professional electronic-structure codes, topological quantum chemistry tools, Wannier-based workflows, many-body exact diagonalization systems, tensor-network libraries, or validated materials pipelines. The goal is to provide transparent scaffolding for:

- SSH winding numbers
- two-band Chern-number calculations
- Berry curvature grids
- Wilson-loop scaffolds
- bulk-boundary correspondence toy models
- Kitaev-chain diagnostics
- topological phase-label metadata
- source provenance
- reproducibility documentation

## Assumptions

The introductory workflows assume:

- lattice spacing set to unity unless stated otherwise
- dimensionless momentum coordinates over the Brillouin zone
- noninteracting band models for the main computational examples
- finite-difference grids for Berry-curvature and Chern-number estimates
- simplified SSH and two-band Chern models
- no production electronic-structure pipeline
- no interacting many-body topological-order solver

## Computational Philosophy

The code is organized by scientific role:

- Python: Chern numbers, Berry curvature, Wilson loops, edge-state toys, Kitaev diagnostics
- R: winding-number sweeps and phase summaries
- Julia: compact band-topology calculations
- C++: performance-oriented phase sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for models, invariants, symmetries, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
