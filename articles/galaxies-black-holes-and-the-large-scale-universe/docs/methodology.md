# Methodology Notes

## Purpose

This repository folder supports an article on galaxies, black holes, and the large-scale universe by turning introductory astrophysical relations into reproducible computational workflows.

The goal is not to replace professional galaxy-dynamics, relativistic, or cosmological software. The goal is to provide transparent scaffolding for:

- galaxy rotation-curve intuition
- enclosed-mass estimation
- black-hole horizon-scale calculation
- redshift and Hubble-style scaling
- cosmic-web environment metadata
- reproducible astrophysical tables

## Core Physical Ideas

### Circular Velocity and Enclosed Mass

v(r)^2 = G M(r) / r

Rearranged:

M(r) = v(r)^2 r / G

This relation links observed orbital speed to enclosed gravitating mass.

### Schwarzschild Radius

r_s = 2GM / c^2

This gives the horizon scale for a nonrotating black hole in the simplest idealized case.

### Low-Redshift Hubble Relation

v = H0 d

This is useful for low-redshift expansion intuition, not high-redshift precision cosmology.

### Redshift

1 + z = lambda_obs / lambda_emit

This connects observed wavelength stretching to cosmological redshift.

## Assumptions

The introductory workflows assume:

- schematic flat rotation curves
- Newtonian circular-orbit approximations
- nonrotating Schwarzschild black-hole radius as a baseline scale
- representative educational values for masses and velocities
- no relativistic disk modeling
- no baryonic feedback modeling
- no full cosmological parameter inference

## Limitations

These workflows should not be used as production astrophysical constraints. They are teaching and scaffolding tools for understanding the relationships among observed motion, mass, black-hole scale, redshift, and large-scale structure.

## Computational Philosophy

The code is organized by scientific role:

- Python: transparent astrophysical tables and scaling calculations
- R: survey-style summaries and schematic rotation-curve comparison
- Julia: orbital-motion scaffolding
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing table generation
- SQL: structured metadata for galaxies, black holes, and cosmic-web environments
- Rust: safe command-line utility
- C: low-level table calculation
