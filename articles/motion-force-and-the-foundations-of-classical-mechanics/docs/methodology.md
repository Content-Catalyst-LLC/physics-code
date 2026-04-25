# Methodology Notes

## Purpose

This repository folder supports an article on motion, force, and classical mechanics by translating core kinematic and Newtonian relations into reproducible computational workflows.

The goal is not to replace professional multibody dynamics software, finite-element modeling, calibrated laboratory acquisition systems, or high-fidelity aerospace simulation. The goal is to provide transparent scaffolding for:

- ideal projectile motion
- drag-including projectile motion
- Newtonian force-to-acceleration calculations
- trajectory fitting and residual analysis
- impulse-momentum calculations
- finite-difference kinematic estimates
- free-body and force-model metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Kinematics

v = dr/dt

a = d2r/dt2

### Dynamics

F_net = m a

### Momentum and Impulse

p = m v

J = integral F dt = Delta p

### Projectile Motion

x(t) = x0 + v0 cos(theta) t

y(t) = y0 + v0 sin(theta) t - 1/2 g t^2

### Drag Scaffold

A compact quadratic drag model can be represented as:

a_drag = -c |v| v

This is a teaching model, not a calibrated aerodynamic model.

## Assumptions

The introductory workflows assume:

- point-particle motion unless otherwise stated
- SI units
- constant near-surface gravitational acceleration
- flat-ground projectile examples unless otherwise specified
- no air resistance in ideal projectile motion
- simple quadratic drag in the drag comparison scaffold
- no spin, lift, wind, buoyancy, rolling, or rigid-body rotation
- no relativistic corrections
- no quantum effects
- no production-grade uncertainty propagation unless extended separately

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for professional trajectory simulation, calibrated drag models, rigid-body dynamics software, or laboratory-grade data acquisition.

## Computational Philosophy

The code is organized by scientific role:

- Python: ODE integration, trajectory simulation, force laws, impulse-momentum calculations
- R: trajectory fitting, residual analysis, measurement summaries, visualization-ready outputs
- Julia: compact force-law and projectile integration scaffolding
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing kinematics tables
- SQL: structured metadata for systems, force models, constants, assumptions, and sources
- Rust: safe command-line utility
- C: low-level projectile calculations
