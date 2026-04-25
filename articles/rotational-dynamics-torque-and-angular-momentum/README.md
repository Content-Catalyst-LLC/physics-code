# Rotational Dynamics, Torque, and Angular Momentum

This folder supports the Physics knowledge-series article **Rotational Dynamics, Torque, and Angular Momentum**.

The article examines angular position, angular velocity, angular acceleration, moment of inertia, torque, rotational dynamics, rotational kinetic energy, rolling without slipping, angular momentum, angular impulse, gyroscopes, precession, SI unit interpretation, and the relation between translational and rotational mechanics.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible rotational-dynamics workflows.

## Included Materials

- Python workflows for torque-driven rotation, angular momentum, rotational energy, rolling-body comparison, and gyroscope-style precession scaffolding
- R workflows for rolling objects, inertia factors, energy partition, and rotational measurement summaries
- Julia rotational-dynamics and rolling-motion scaffolds
- C++ rolling and torque parameter sweeps
- Fortran moment-of-inertia and rolling tables
- SQL metadata for rotational systems, moments of inertia, torque models, rolling constraints, source notes, assumptions, and simulation runs
- Rust command-line utility for rolling-body comparisons
- C low-level moment-of-inertia and rolling calculations
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Angular position from arc length:

theta = s / r

Angular velocity:

omega = d theta / dt

Angular acceleration:

alpha = d omega / dt

Tangential speed:

v = r omega

Tangential acceleration:

a_t = r alpha

Centripetal acceleration:

a_c = r omega^2 = v^2 / r

Moment of inertia:

I = sum_i m_i r_i^2

Continuous moment of inertia:

I = integral r^2 dm

Torque:

tau = r x F

Torque magnitude:

tau = r F sin(phi)

Fixed-axis rotational dynamics:

tau_net = I alpha

General torque-angular momentum relation:

tau_net = dL/dt

Rotational kinetic energy:

K_rot = 1/2 I omega^2

Angular momentum:

L = r x p

Rigid-body angular momentum about fixed symmetry axis:

L = I omega

Rolling without slipping:

v_cm = R omega

Rolling kinetic energy:

K_total = 1/2 M v_cm^2 + 1/2 I_cm omega^2

Rolling acceleration for I = beta M R^2:

a = g sin(theta) / (1 + beta)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/rotational-dynamics-torque-and-angular-momentum
