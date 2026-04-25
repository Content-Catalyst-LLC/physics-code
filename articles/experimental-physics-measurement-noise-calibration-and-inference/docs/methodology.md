# Methodology Notes

## Purpose

This repository folder supports an article on experimental physics by translating measurement models, calibration curves, noise analysis, uncertainty propagation, Bayesian inference, residual diagnostics, and reproducible laboratory metadata into computational workflows.

The goal is not to replace professional laboratory information management systems, accredited calibration systems, instrument-control frameworks, or validated metrology packages. The goal is to provide transparent scaffolding for:

- measurement models
- uncertainty budgets
- calibration curve fitting
- residual diagnostics
- noise simulation
- signal-to-noise ratio estimation
- Fourier noise diagnostics
- Monte Carlo uncertainty propagation
- Bayesian measurement inference
- instrument and calibration metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Measurement Model

y = f(x_1, x_2, ..., x_n)

### Standard Uncertainty of Mean

u_xbar = s/sqrt(n)

### Combined Standard Uncertainty

u_c = sqrt(sum_i u_i^2)

### Expanded Uncertainty

U = k u_c

### Propagation of Uncertainty

u_y^2 = J Sigma J^T

### Calibration Model

y = alpha + beta x

### Signal-to-Noise Ratio

SNR = signal_rms/noise_rms

### Bayesian Update

p(theta|D) proportional to p(D|theta)p(theta)

## Assumptions

The introductory workflows assume:

- SI units unless otherwise stated
- independent uncertainty components unless covariance is explicitly included
- Gaussian noise for selected examples
- linear calibration models where specified
- simple sinusoidal signal simulation for noise demonstrations
- normal likelihoods for Bayesian examples
- transparent teaching models rather than production metrology pipelines
- no direct hardware control
- no certified calibration output

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for accredited laboratory procedures, certified calibration systems, instrument vendor software, laboratory quality-management systems, or formally validated metrology software.

## Computational Philosophy

The code is organized by scientific role:

- Python: noise simulation, uncertainty propagation, calibration fitting, Fourier diagnostics, Bayesian inference
- R: calibration summaries, residual diagnostics, uncertainty-budget reporting
- Julia: compact experimental calculations
- C++: performance-oriented sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for instruments, calibrations, measurements, uncertainty budgets, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
