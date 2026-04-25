# Methodology Notes

## Purpose

This repository folder supports an article on special relativity by translating core relativistic relations into reproducible computational workflows.

The goal is not to replace a full tensor algebra system, accelerator simulation package, detector-analysis framework, or relativistic navigation system. The goal is to provide transparent scaffolding for:

- Lorentz-factor calculation
- time dilation and length contraction
- Lorentz transformation of event coordinates
- spacetime interval invariance
- relativistic velocity composition
- rapidity boost composition
- relativistic Doppler shifts
- energy and momentum scaling
- reproducibility metadata

## Core Ideas

### Lorentz Factor

gamma = 1 / sqrt(1 - beta^2)

where beta = v/c.

### Lorentz Transformation

For motion along the x-axis:

x_prime = gamma (x - beta ct)

ct_prime = gamma (ct - beta x)

The examples often use ct and x in compatible length units so that c does not have to be carried explicitly.

### Spacetime Interval

Delta s^2 = (c Delta t)^2 - Delta x^2 - Delta y^2 - Delta z^2

The interval is invariant under Lorentz transformation.

### Velocity Composition

u_prime = (u - v) / (1 - uv/c^2)

In dimensionless units:

beta_u_prime = (beta_u - beta_v) / (1 - beta_u beta_v)

### Rapidity

beta = tanh eta

Rapidity composes additively for collinear boosts.

## Assumptions

The introductory workflows assume:

- inertial frames
- flat Minkowski spacetime
- motion primarily along one spatial axis
- no gravity
- no acceleration except when used as an interpretive extension
- no general-relativistic curvature
- no quantum effects
- no detector-specific calibration model
- no production navigation-system implementation

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for high-precision timing software, professional accelerator modeling, detector reconstruction, or relativistic navigation systems.

## Computational Philosophy

The code is organized by scientific role:

- Python: event transformations, interval checks, rapidity, Doppler models, numerical tables
- R: parameter sweeps, summaries, residual comparisons, visualization-ready outputs
- Julia: rapidity and boost-composition scaffolding
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing table generation
- SQL: structured metadata for frames, events, constants, transformations, and sources
- Rust: safe command-line utility
- C: low-level numerical calculation
