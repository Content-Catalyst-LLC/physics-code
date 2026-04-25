# Methodology Notes

## Purpose

This repository folder supports an article on rotational dynamics by translating core fixed-axis and rolling-motion relations into reproducible computational workflows.

The goal is not to replace professional multibody dynamics software, rigid-body engines, spacecraft attitude-control packages, gyroscope calibration systems, or high-fidelity mechanical simulation. The goal is to provide transparent scaffolding for:

- angular kinematics
- moment-of-inertia comparison
- torque-driven angular acceleration
- angular momentum and rotational kinetic energy
- rolling without slipping
- energy partition between translation and rotation
- angular impulse
- gyroscope-style precession estimates
- rotational measurement metadata
- reproducibility documentation

## Core Ideas

### Angular Kinematics

omega = d theta / dt

alpha = d omega / dt

v = r omega

a_t = r alpha

### Moment of Inertia

I = sum_i m_i r_i^2

I = integral r^2 dm

### Torque

tau = r x F

tau_net = I alpha

tau_net = dL/dt

### Rotational Energy

K_rot = 1/2 I omega^2

### Angular Momentum

L = r x p

L = I omega for fixed-axis rotation about a principal axis

### Rolling Without Slipping

v_cm = R omega

K_total = 1/2 M v_cm^2 + 1/2 I_cm omega^2

If I = beta M R^2:

a = g sin(theta) / (1 + beta)

v = sqrt(2 g h / (1 + beta))

## Assumptions

The introductory workflows assume:

- rigid bodies unless otherwise stated
- fixed-axis rotation for torque-driven examples
- scalar moment of inertia for rotation about a principal axis
- rolling without slipping for rolling examples
- simple dimensionless inertia factors beta
- SI units
- no deformation, bearing friction, slip, or rolling resistance unless added separately
- no full inertia tensor dynamics in introductory scripts
- no production multibody simulation
- no calibrated gyroscope sensor model

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for high-fidelity rigid-body dynamics, spacecraft attitude simulation, robotics dynamics engines, or experimental calibration systems.

## Computational Philosophy

The code is organized by scientific role:

- Python: torque integration, angular momentum, rotational energy, rolling comparison, precession scaffolds
- R: parameter summaries, energy partition, measurement-ready rotational tables
- Julia: compact rotational-dynamics and rolling-motion scaffolding
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing moment-of-inertia tables
- SQL: structured metadata for rotational systems, constants, assumptions, and source provenance
- Rust: safe command-line utility
- C: low-level numerical calculations
