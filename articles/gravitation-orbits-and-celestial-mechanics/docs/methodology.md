# Methodology Notes

## Purpose

This repository folder supports an article on gravitation, orbits, and celestial mechanics by translating Newtonian gravitational relations into reproducible computational workflows.

The goal is not to replace professional astrodynamics libraries, mission-design software, ephemeris systems, or high-precision orbit determination tools. The goal is to provide transparent scaffolding for:

- circular orbit speed
- escape speed
- Keplerian period scaling
- two-body integration
- conservation diagnostics
- orbital energy classification
- Hohmann transfer estimates
- orbital metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Newtonian Gravitation

F = G m1 m2 / r^2

### Gravitational Parameter

mu = G M

### Circular Orbit

v_circ = sqrt(mu/r)

T = 2 pi sqrt(r^3/mu)

### Escape Speed

v_esc = sqrt(2 mu/r)

### Specific Orbital Energy

epsilon = v^2/2 - mu/r

### Elliptical Orbit Energy

epsilon = -mu/(2a)

### Vis-Viva Equation

v^2 = mu(2/r - 1/a)

### Angular Momentum

h = r x v

### Hohmann Transfer

a_t = (r1 + r2)/2

## Assumptions

The introductory workflows assume:

- Newtonian gravity
- two-body motion unless otherwise stated
- central gravitational field
- point-mass or spherically symmetric body approximation
- SI units
- no atmospheric drag unless added separately
- no oblateness perturbations unless added separately
- no solar radiation pressure unless added separately
- no relativistic corrections unless added separately
- no production ephemerides
- no high-fidelity mission design

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for JPL Horizons, SPICE, Orekit, GMAT, STK, poliastro, Tudat, or professional mission-analysis environments.

## Computational Philosophy

The code is organized by scientific role:

- Python: ODE integration, conservation diagnostics, energy, transfers, orbit tables
- R: orbital scaling summaries, tabular analysis, period-law diagnostics
- Julia: compact high-performance orbit and transfer scaffolds
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing orbital tables
- SQL: structured metadata for bodies, constants, orbital cases, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
