# Methodology Notes

## Purpose

This repository folder supports an article on general relativity by translating metric geometry, Schwarzschild scales, gravitational redshift, weak-field limits, orbital precession, curvature metadata, and cosmological expansion into reproducible computational workflows.

The goal is not to replace numerical relativity codes, full tensor-algebra systems, gravitational-wave inference pipelines, cosmological Boltzmann solvers, or professional relativity packages. The goal is to provide transparent scaffolding for:

- Schwarzschild radius
- compactness
- gravitational redshift
- weak-field time dilation
- weak-field orbital precession
- light-deflection scales
- curvature and metric metadata
- Friedmann expansion scales
- source provenance
- reproducibility documentation

## Core Ideas

### Metric

ds^2 = g_mu_nu dx^mu dx^nu

### Geodesic Equation

d^2x^mu/dlambda^2 + Gamma^mu_alpha_beta dx^alpha/dlambda dx^beta/dlambda = 0

### Einstein Field Equation

G_mu_nu + Lambda g_mu_nu = (8 pi G/c^4) T_mu_nu

### Schwarzschild Radius

r_s = 2 G M/c^2

### Gravitational Redshift

1 + z = 1/sqrt(1 - r_s/r)

### Weak-Field Light Deflection

Delta phi approx 4 G M/(b c^2)

### Friedmann Equation

H^2 = (8 pi G/3) rho - k c^2/a^2 + Lambda c^2/3

## Assumptions

The introductory workflows assume:

- SI units unless otherwise stated
- non-rotating spherical mass for Schwarzschild calculations
- weak-field approximations where documented
- test-particle motion where backreaction is ignored
- simplified post-Newtonian-style correction for precession
- no full geodesic integration in Kerr spacetime
- no numerical solution of the full Einstein field equation
- no gravitational-wave parameter estimation
- no full cosmological perturbation solver

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for professional numerical relativity, Einstein Toolkit, SpEC, GRChombo, LALSuite, GRTensor, xAct, SageManifolds, CLASS, CAMB, or validated scientific pipelines.

## Computational Philosophy

The code is organized by scientific role:

- Python: numerical diagnostics, weak-field orbits, symbolic examples, cosmology scales
- R: parameter sweeps, scale comparisons, reproducible summaries
- Julia: compact relativity calculations
- C++: performance-oriented orbit sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for constants, metrics, relations, tests, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
