# Experimental Physics: Measurement, Noise, Calibration, and Inference

This folder supports the Physics knowledge-series article **Experimental Physics: Measurement, Noise, Calibration, and Inference**.

The article examines measurement models, measurands, instruments, calibration, traceability, precision, accuracy, repeatability, reproducibility, Type A and Type B uncertainty, systematic effects, random noise, Gaussian and non-Gaussian error, uncertainty propagation, least-squares fitting, calibration curves, signal-to-noise ratio, filtering, Fourier analysis, Bayesian inference, model comparison, residual diagnostics, experimental design, blind analysis, replication, open data, and reproducible laboratory computation.

## Repository Purpose

This folder provides advanced computational scaffolding for extending the article's selected examples into reproducible experimental-physics workflows.

## Included Materials

- Python workflows for noise simulation, uncertainty propagation, calibration fitting, Fourier noise diagnostics, Bayesian measurement inference, and Monte Carlo uncertainty
- R workflows for calibration residual diagnostics and uncertainty-budget summaries
- Julia experimental calculation scaffolding
- C++ signal and calibration sweeps
- Fortran uncertainty tables
- SQL metadata for instruments, calibrations, measurements, uncertainty budgets, assumptions, sources, and simulation runs
- Rust command-line utility for uncertainty and SNR calculations
- C low-level uncertainty calculations
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Measurement model:

y = f(x_1, x_2, ..., x_n)

Sample mean:

x_bar = (1/n) sum_i x_i

Sample variance:

s^2 = (1/(n-1)) sum_i (x_i - x_bar)^2

Standard uncertainty of mean:

u_xbar = s/sqrt(n)

Combined standard uncertainty:

u_c = sqrt(sum_i u_i^2)

Expanded uncertainty:

U = k u_c

Linearized uncertainty propagation:

u_y^2 = sum_i (partial f/partial x_i)^2 u_x_i^2

Linear calibration model:

y = alpha + beta x

Signal-to-noise ratio:

SNR = signal_rms/noise_rms

Bayes theorem:

p(theta|D) proportional to p(D|theta)p(theta)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/experimental-physics-measurement-noise-calibration-and-inference
