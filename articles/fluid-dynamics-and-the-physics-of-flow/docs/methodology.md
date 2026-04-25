# Methodology Notes

## Purpose

This repository folder supports an article on fluid dynamics by translating core fluid relations into reproducible computational workflows.

The goal is not to replace professional CFD environments, laboratory flow measurement systems, high-fidelity turbulence models, or engineering design software. The goal is to provide transparent scaffolding for:

- Reynolds-number classification
- pipe-flow diagnostics
- Bernoulli calculations
- hydrostatic pressure estimates
- velocity-field diagnostics
- divergence and vorticity
- advection-diffusion transport
- dimensionless-number summaries
- fluid-property metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Field Description

u = u(x,t)

p = p(x,t)

rho = rho(x,t)

### Material Derivative

D/Dt = partial/partial t + u dot grad

### Continuity

partial rho/partial t + div(rho u) = 0

For incompressible flow:

div(u) = 0

### Bernoulli Equation

p + 1/2 rho v^2 + rho g z = constant

### Viscosity

tau = mu du/dy

nu = mu/rho

### Navier-Stokes

rho(partial u/partial t + (u dot grad)u) = -grad p + mu laplacian u + f

### Reynolds Number

Re = rho v L / mu

### Vorticity

omega = curl u

## Assumptions

The introductory workflows assume:

- continuum approximation
- SI units
- Newtonian fluid behavior unless otherwise stated
- incompressible flow for many examples
- simple pipe-flow regime thresholds as teaching categories
- no high-fidelity turbulence modeling
- no compressible shock physics
- no multiphase flow
- no reactive flow
- no production CFD meshing
- no professional validation workflow

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for OpenFOAM, SU2, ANSYS Fluent, COMSOL, STAR-CCM+, Nek5000, Dedalus, or calibrated experimental fluid mechanics.

## Computational Philosophy

The code is organized by scientific role:

- Python: vector-field diagnostics, finite differences, vorticity, transport scaffolds
- R: parameter summaries, Reynolds-number tables, fluid-property summaries
- Julia: compact high-performance flow calculations
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing flow tables
- SQL: structured metadata for fluids, flow cases, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
