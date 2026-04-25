# Methodology Notes

## Purpose

This repository folder supports an article on physics beyond the Standard Model by turning central BSM reasoning patterns into reproducible computational examples.

The goal is not to provide production-level phenomenology. The goal is to build transparent scaffolding for:

- relic-density-style scaling
- cosmic inventory comparison
- simplified parameter scans
- toy constraints
- model metadata
- reproducible BSM workflows

## Core Physical Ideas

### Standard Model Gauge Structure

G_SM = SU(3)_C x SU(2)_L x U(1)_Y

BSM theories may extend this by adding:

- new fields
- new gauge factors
- new scalar sectors
- new fermions
- hidden-sector portals
- higher-dimensional operators
- new symmetry-breaking patterns

### Relic-Density-Style Scaling

A common rough intuition for thermal dark matter is:

Omega_chi h^2 ∝ 1 / <sigma v>

where:

- Omega_chi h^2 is the dark-matter relic-density contribution
- <sigma v> is a thermally averaged annihilation quantity

This is not a full freeze-out calculation. It is a schematic relation useful for conceptual modeling.

### Portal Coupling

A schematic Higgs portal interaction may be written:

L_portal includes lambda_HS |H|^2 S^2

where:

- H is the Standard Model Higgs field
- S is a new scalar field
- lambda_HS controls the coupling between sectors

## Assumptions

The toy workflows assume:

- simplified one-parameter relic scaling
- schematic units for annihilation strength
- educational parameter ranges
- no full Boltzmann solver
- no detector efficiencies
- no astrophysical backgrounds
- no global likelihood combination

## Limitations

These workflows should not be used as production physics constraints. They are teaching and scaffolding tools for understanding BSM logic.

## Computational Philosophy

The code is organized by scientific role:

- Python: transparent relic scaling and parameter scans
- R: cosmic inventory and model comparison summaries
- Julia: simple dynamical freeze-out toy model
- C++: performance-oriented parameter scan loops
- Fortran: classic scientific-computing table generation
- SQL: structured metadata for models, assumptions, sources, and constraints
- Rust: safe command-line utility
- C: low-level likelihood-style calculation
