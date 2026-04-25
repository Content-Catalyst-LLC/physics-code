# Methodology Notes

## Purpose

This repository folder supports an article on experimental physics by turning measurement-chain and uncertainty-analysis ideas into reproducible computational workflows.

The goal is not to replace laboratory-specific analysis. The goal is to provide transparent scaffolding for:

- repeated measurement summaries
- measurement models
- first-order uncertainty propagation
- Monte Carlo uncertainty propagation
- calibration fitting
- detector-style signal chains
- metadata discipline
- reproducible experimental workflows

## Core Ideas

### Measurement Model

A measured result is often represented as:

y = f(x1, x2, ..., xn)

where y is the output quantity or measurand and the x_i are measured or referenced inputs.

### First-Order Propagation

For uncorrelated inputs:

u_c^2(y) = sum_i [(partial f / partial x_i)^2 u^2(x_i)]

For correlated inputs, covariance terms should be added.

### Pendulum Example

g = 4 pi^2 L / T^2

where:

- L is pendulum length
- T is oscillation period
- g is inferred gravitational acceleration

### Linear Calibration

y = a x + b

where:

- x is instrument reading
- y is calibrated physical value
- a is slope
- b is offset

## Assumptions

The introductory workflows assume:

- uncorrelated length and timing uncertainties in the pendulum example
- normal input distributions for Monte Carlo propagation
- educational calibration data
- simplified detector response
- no laboratory-specific environmental corrections
- no covariance unless explicitly introduced
- no full GUM-compliant uncertainty report

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for discipline-specific laboratory procedures, validated uncertainty budgets, or accredited calibration workflows.

## Computational Philosophy

The code is organized by scientific role:

- Python: measurement models, uncertainty propagation, Monte Carlo simulation, and signal-chain modeling
- R: repeated measurement summaries, calibration residuals, and transparent tabular analysis
- Julia: numerical uncertainty propagation scaffold
- C++: performance-oriented signal-chain parameter sweeps
- Fortran: classic scientific-computing table generation
- SQL: structured metadata for instruments, calibrations, measurements, and analysis lineage
- Rust: safe command-line utility
- C: low-level uncertainty example
