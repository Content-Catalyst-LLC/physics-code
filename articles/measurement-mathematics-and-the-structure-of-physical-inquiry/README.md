# Measurement, Mathematics, and the Structure of Physical Inquiry

This folder supports the Physics knowledge-series article **Measurement, Mathematics, and the Structure of Physical Inquiry**.

The article examines measurement, metrology, the SI, physical quantities, units, dimensions, mathematical structure, laws, models, idealization, uncertainty, traceability, reproducibility, computation, and the role of disciplined quantification in physics.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible measurement and modeling workflows.

## Included Materials

- Python workflows for nonlinear pendulum modeling, small-angle approximation comparison, uncertainty propagation, and dimensional-reasoning utilities
- R workflows for repeated measurement, uncertainty estimation, residual analysis, and measurement summaries
- Julia pendulum and model-comparison scaffolding
- C++ pendulum and uncertainty parameter sweeps
- Fortran measurement and pendulum tables
- SQL metadata for measurements, constants, units, dimensions, traceability, source notes, model assumptions, and simulation runs
- Rust command-line utility for pendulum-derived gravity estimates
- C low-level pendulum measurement example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Velocity dimension:

[v] = L T^-1

Force dimension:

[F] = M L T^-2

Energy dimension:

[E] = M L^2 T^-2

Velocity:

v = dx/dt

Acceleration:

a = d^2x/dt^2

Constant-acceleration model:

x(t) = x0 + v0 t + 1/2 a t^2

Pendulum small-angle period:

T = 2 pi sqrt(L/g)

Gravity estimated from period:

g = 4 pi^2 L / T^2

First-order uncertainty propagation:

u_c^2(y) = sum_i (partial f / partial x_i)^2 u^2(x_i)

Pendulum uncertainty propagation:

u_c^2(g) =
  (partial g / partial L)^2 u^2(L) +
  (partial g / partial T)^2 u^2(T)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/measurement-mathematics-and-the-structure-of-physical-inquiry
