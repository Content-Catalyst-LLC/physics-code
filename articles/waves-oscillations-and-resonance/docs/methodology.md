# Methodology Notes

## Purpose

This repository folder supports an article on waves, oscillations, and resonance by translating oscillator and wave relations into reproducible computational workflows.

The goal is not to replace professional acoustics software, finite-element vibration analysis, optical simulation packages, signal-processing platforms, or high-fidelity computational wave solvers. The goal is to provide transparent scaffolding for:

- simple harmonic motion
- damped oscillators
- driven oscillators
- resonance curves
- quality factor estimates
- standing-wave modes
- wave speed and frequency relationships
- finite-difference wave-equation scaffolds
- Fourier decomposition
- metadata and reproducibility documentation

## Core Ideas

### Simple Harmonic Motion

d2x/dt2 + omega0^2 x = 0

omega0 = sqrt(k/m)

### Damping

d2x/dt2 + 2 gamma dx/dt + omega0^2 x = 0

### Driving and Resonance

d2x/dt2 + 2 gamma dx/dt + omega0^2 x = (F0/m) cos(omega t)

A(omega) = (F0/m) / sqrt((omega0^2 - omega^2)^2 + (2 gamma omega)^2)

### Waves

y(x,t) = A cos(kx - omega t + phi)

v = omega/k = f lambda

### Wave Equation

d2y/dt2 = v^2 d2y/dx2

### Standing Waves

lambda_n = 2L/n

f_n = n v/(2L)

### Beats

f_beat = |f1 - f2|

## Assumptions

The introductory workflows assume:

- linear oscillators unless otherwise stated
- viscous damping for damped oscillator examples
- sinusoidal driving for resonance examples
- one-dimensional waves for introductory wave-equation scaffolding
- fixed-end boundary conditions for standing-wave examples
- SI units
- no nonlinear restoring forces unless added separately
- no multi-dimensional PDE simulation in the introductory scripts
- no high-fidelity acoustics, optics, or structural simulation
- no production-grade signal-processing pipeline

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for finite-element modal analysis, professional acoustics packages, electromagnetic solvers, optical design software, or calibrated laboratory measurement systems.

## Computational Philosophy

The code is organized by scientific role:

- Python: ODE integration, wave-equation scaffolds, Fourier decomposition, numerical diagnostics
- R: resonance curves, parameter summaries, frequency tables, measurement-ready outputs
- Julia: compact high-performance oscillator and wave scaffolding
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing standing-wave tables
- SQL: structured metadata for wave systems, modes, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
