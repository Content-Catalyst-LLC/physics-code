# Methodology Notes

## Purpose

This repository folder supports an article on measurement, mathematics, and physical inquiry by translating foundational metrological and modeling concepts into reproducible computational workflows.

The goal is not to replace professional metrology systems, laboratory information-management systems, calibration services, Bayesian uncertainty engines, or formal dimensional-analysis packages. The goal is to provide transparent scaffolding for:

- repeated measurement analysis
- uncertainty estimation
- uncertainty propagation
- dimensional reasoning
- pendulum-based gravity estimation
- ideal versus nonlinear model comparison
- model residual analysis
- traceability and source metadata
- reproducibility documentation

## Core Ideas

### Quantity and Unit

A measured physical quantity should be reported with a numerical value, unit, method, and uncertainty.

### Dimensional Coherence

Equations must be dimensionally coherent. For example:

[v] = L T^-1

[F] = M L T^-2

[E] = M L^2 T^-2

### Pendulum Measurement

Small-angle period:

T = 2 pi sqrt(L/g)

Inverted gravity estimate:

g = 4 pi^2 L / T^2

### Uncertainty Propagation

For y = f(x1, x2, ..., xn):

u_c^2(y) = sum_i (partial f / partial x_i)^2 u^2(x_i)

For g = 4 pi^2 L / T^2:

partial g / partial L = 4 pi^2 / T^2

partial g / partial T = -8 pi^2 L / T^3

## Assumptions

The introductory workflows assume:

- SI units
- independent uncertainty sources unless otherwise stated
- first-order uncertainty propagation
- small-angle pendulum approximation for analytic estimates
- finite repeated measurements for empirical period uncertainty
- simple nonlinear pendulum simulation for model comparison
- no correlated uncertainty terms unless extended separately
- no formal Bayesian hierarchical model unless added separately
- no professional calibration certificate workflow
- no production laboratory-information system

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for ISO/IEC 17025 calibration systems, professional metrology software, formal GUM Supplement Monte Carlo workflows, or calibrated laboratory measurement chains.

## Computational Philosophy

The code is organized by scientific role:

- Python: nonlinear modeling, numerical simulation, dimensional tables, uncertainty propagation
- R: repeated-measurement statistics, residual summaries, uncertainty reporting
- Julia: compact nonlinear model-comparison scaffolding
- C++: parameter sweeps and performance-oriented computation
- Fortran: classic scientific-computing measurement tables
- SQL: structured metadata for constants, units, measurements, assumptions, and source provenance
- Rust: safe command-line utility
- C: low-level measurement calculations
