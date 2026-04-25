# Experiment, Instruments, and the Material Practice of Physics

This folder supports the Physics knowledge-series article **Experiment, Instruments, and the Material Practice of Physics**.

The article examines experimental physics as a material and computational practice built from instruments, calibration, uncertainty, laboratory notebooks, detector systems, measurement chains, and reproducible analysis.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible experimental-physics workflows.

## Included Materials

- Python workflows for first-order uncertainty propagation, Monte Carlo measurement models, calibration fitting, and detector-style signal-chain simulation
- R workflows for repeated measurements, pendulum timing summaries, and calibration residual analysis
- Julia measurement-model and uncertainty-propagation scaffold
- C++ detector-style signal-chain parameter sweep
- Fortran uncertainty table generation
- SQL metadata for experiments, instruments, calibration records, uncertainty budgets, measurement chains, and analysis scripts
- Rust command-line utility for pendulum uncertainty calculation
- C low-level uncertainty-propagation example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Measurement model:

y = f(x1, x2, ..., xn)

Uncorrelated first-order uncertainty propagation:

u_c^2(y) = sum_i [(partial f / partial x_i)^2 u^2(x_i)]

Pendulum estimate:

g = 4 pi^2 L / T^2

Linear calibration model:

y = a x + b

Signal-to-noise ratio:

SNR = signal / noise

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/experiment-instruments-and-the-material-practice-of-physics
