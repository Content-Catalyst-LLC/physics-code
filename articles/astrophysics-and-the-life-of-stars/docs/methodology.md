# Methodology Notes

## Purpose

This repository folder supports an article on stellar astrophysics by turning introductory stellar-structure and stellar-evolution relations into reproducible computational workflows.

The goal is not to replace professional stellar-evolution codes such as MESA. The goal is to provide transparent scaffolding for:

- mass-luminosity scaling
- main-sequence lifetime intuition
- H-R diagram structure
- Stefan-Boltzmann radius-temperature-luminosity relations
- hydrostatic-equilibrium toy modeling
- stellar metadata and observational scaffolds

## Core Physical Ideas

### Hydrostatic Equilibrium

dP/dr = -G M(r) rho(r) / r^2

This relation balances inward gravity against outward pressure gradients.

### Mass Continuity

dM/dr = 4 pi r^2 rho(r)

This relation describes how enclosed mass changes with radius.

### Stefan-Boltzmann Luminosity

L = 4 pi R^2 sigma T_eff^4

This relation links luminosity, radius, and effective temperature.

### Mass-Luminosity Scaling

L / L_sun = (M / M_sun)^3.5

This is an approximate main-sequence relation and should not be treated as universal across all stellar masses.

### Lifetime Scaling

t / t_sun = M / L

This captures the intuition that more luminous stars consume fuel faster.

## Assumptions

The introductory workflows assume:

- simplified main-sequence scaling
- solar-normalized units
- no detailed opacity tables
- no stellar atmosphere models
- no metallicity dependence
- no rotation
- no mass loss
- no binary evolution
- no convective overshoot
- no detailed nuclear reaction network

## Limitations

These workflows are teaching and scaffolding tools. They are not production stellar-evolution models and should not be used as calibrated stellar-age or stellar-structure predictions.

## Computational Philosophy

The code is organized by scientific role:

- Python: transparent scaling calculations and H-R-style tables
- R: observational-style summaries and tabular comparison
- Julia: differential-equation style hydrostatic-equilibrium scaffold
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing table generation
- SQL: structured metadata for stellar stages and model assumptions
- Rust: safe command-line utility
- C: low-level stellar scaling example
