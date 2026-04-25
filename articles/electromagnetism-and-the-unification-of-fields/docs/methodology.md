# Methodology Notes

## Purpose

This repository folder supports an article on electromagnetism by translating core field-theory relations into reproducible computational workflows.

The goal is not to replace professional electromagnetic simulation software, finite-element packages, circuit-field co-simulation tools, antenna solvers, or calibrated metrology systems. The goal is to provide transparent scaffolding for:

- point-charge field and potential calculation
- electric-field recovery from potential
- dipole-style field superposition
- magnetic-field scaling around straight wires
- measured-vs-theoretical residual comparison
- finite-difference Laplace boundary problems
- Maxwell-wave relation checks
- material-property metadata
- electromagnetic-unit and source provenance
- reproducibility documentation

## Core Ideas

### Electric Field of a Point Charge

E(r) = q / (4 pi epsilon_0 r^2)

### Electric Potential

V(r) = q / (4 pi epsilon_0 r)

### Field from Potential

E = -grad V

### Straight-Wire Magnetic Field

B(r) = mu_0 I / (2 pi r)

### Lorentz Force

F = q(E + v x B)

### Faraday Induction

integral E dot dl = - d Phi_B / dt

### Maxwell Wave Relation

c = 1 / sqrt(mu_0 epsilon_0)

## Assumptions

The introductory workflows assume:

- classical electromagnetism
- vacuum constants unless material properties are explicitly specified
- point-charge and idealized-wire approximations
- scalar electrostatic potential in static cases
- no radiation reaction
- no relativistic particle tracking unless extended separately
- no full finite-element solver
- no antenna far-field solver
- no dispersive or nonlinear constitutive model unless added separately
- no quantum electrodynamics

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for validated electromagnetic simulation packages, calibrated standards-lab measurement systems, antenna design software, or professional high-voltage engineering tools.

## Computational Philosophy

The code is organized by scientific role:

- Python: potential grids, field recovery, superposition, finite-difference scaffolding, wave relations
- R: field scaling, residual analysis, material-property summaries
- Julia: high-performance finite-difference and boundary-value scaffolding
- C++: performance-oriented Coulomb and Lorentz-force sweeps
- Fortran: classic scientific-computing field tables
- SQL: structured metadata for constants, fields, materials, Maxwell relations, sources, and simulation runs
- Rust: safe command-line utility
- C: low-level field calculation
