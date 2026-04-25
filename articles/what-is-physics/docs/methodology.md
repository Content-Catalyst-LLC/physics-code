# Methodology Notes

## Purpose

This repository folder supports an introductory article on physics as a discipline built from measurement, mathematics, experiment, modeling, simulation, uncertainty analysis, and reproducible computation.

## Model System

The main model system is the simple pendulum. It is intentionally simple but conceptually rich because it connects physical law, measurement, idealization, numerical simulation, and model-data comparison.

## Governing Equation: Small-Angle Pendulum

For sufficiently small angular displacement:

T = 2π sqrt(L / g)

where:

- T is the period in seconds
- L is length in meters
- g is gravitational acceleration in meters per second squared

## Dynamical Form

The small-angle pendulum can also be written as:

theta'' = -(g / L) theta

where:

- theta is angular displacement in radians
- theta'' is angular acceleration in radians per second squared
- g is gravitational acceleration
- L is length

## Assumptions

The introductory model assumes:

- small angular displacement
- negligible air resistance
- negligible pivot friction
- point-mass bob
- massless, inextensible string or rod
- rigid support
- constant local gravitational acceleration

## Limitations

The model becomes less accurate when:

- the release angle is large
- damping is significant
- the support is not rigid
- the bob is not point-like
- the string has mass or elasticity
- measurement uncertainty dominates the observed period
- timing is performed manually without adequate repeated trials

## Computational Philosophy

The code is organized by scientific role:

- Python: model implementation, plotting, residual analysis, parameter sweep
- R: repeated-measurement uncertainty and summary statistics
- Julia: differential-equation simulation with Runge-Kutta integration
- C++: performance-oriented numerical loop
- Fortran: classic scientific-computing numerical method
- SQL: structured experiment and simulation metadata
- Rust: safe computational utility
- C: low-level instrumentation-style calculation
