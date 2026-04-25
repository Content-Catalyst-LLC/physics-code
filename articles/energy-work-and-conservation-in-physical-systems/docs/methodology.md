# Methodology Notes

## Purpose

This repository folder supports an article on energy, work, and conservation by translating core mechanics relations into reproducible computational workflows.

The goal is not to replace professional multibody dynamics software, finite-element simulation, calibrated laboratory acquisition systems, or high-fidelity engineering models. The goal is to provide transparent scaffolding for:

- spring-mass energy accounting
- conservative vs damped oscillator comparison
- work-energy theorem checks
- force-displacement work integration
- energy-landscape and turning-point analysis
- power and transfer-rate estimates
- measured-vs-theoretical residual analysis
- unit and source provenance
- reproducibility documentation

## Core Ideas

### Work

W = integral F dot dr

For constant force along displacement:

W = F d

### Work-Energy Theorem

W_net = Delta K

### Mechanical Energy

E = K + U

### Conservative Force

F = -dU/dx

### Spring System

K = 1/2 m v^2

U = 1/2 k x^2

E = K + U

### Damped System

F_d = -b v

P_d = F_d v = -b v^2

## Assumptions

The introductory workflows assume:

- point-mass mechanics
- ideal spring behavior unless damping is specified
- one-dimensional motion for most examples
- SI units
- sign convention where work done on a system increases its mechanical energy unless otherwise stated
- conservative models when total mechanical energy is expected to remain constant
- damping as a simple velocity-proportional force when included
- no relativistic corrections
- no thermal microstate model
- no continuum deformation model
- no production-grade uncertainty propagation unless extended separately

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for experimental calibration, production physics engines, finite-element methods, or high-fidelity dynamics simulation.

## Computational Philosophy

The code is organized by scientific role:

- Python: numerical simulation, ODE integration, energy landscapes, work-energy theorem checks
- R: measurement summaries, residual analysis, energy accounting, visualization-ready outputs
- Julia: compact high-performance energy-landscape and oscillator scaffolding
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for systems, constants, assumptions, and source provenance
- Rust: safe command-line utility
- C: low-level numerical calculations
