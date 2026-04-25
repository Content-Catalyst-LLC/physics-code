# Mathematical Methods in Physics

This folder supports the Physics knowledge-series article **Mathematical Methods in Physics**.

The article examines dimensional analysis, calculus, vector algebra, vector calculus, linear algebra, differential equations, boundary-value problems, Fourier analysis, complex numbers, tensors, probability, statistics, variational methods, numerical methods, computational workflows, and the role of mathematical modeling in physical reasoning.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible mathematical-physics workflows.

## Included Materials

- Python workflows for ODE integration, eigenvalue problems, Fourier spectra, tensor operations, PDE grids, and uncertainty propagation
- R workflows for uncertainty propagation, dimensional-analysis tables, parameter summaries, and measurement-aware modeling
- Julia numerical-methods scaffolding
- C++ finite-difference and eigenvalue parameter sweeps
- Fortran numerical-methods tables
- SQL metadata for equations, variables, dimensions, methods, sources, assumptions, and simulation runs
- Rust command-line utility for dimensional and oscillator calculations
- C low-level numerical-methods example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Velocity:

v = dx/dt

Acceleration:

a = d2x/dt2

Work:

W = integral F dot dr

Gradient:

grad phi

Divergence:

div F

Curl:

curl F

Conservation law:

partial rho/partial t + div J = 0

Linear system:

A x = b

Eigenvalue problem:

A v = lambda v

ODE system:

dx/dt = F(x,t)

Wave equation:

partial2 u/partial t2 = c^2 laplacian u

Diffusion equation:

partial u/partial t = D laplacian u

Fourier transform:

fhat(omega) = integral f(t) exp(-i omega t) dt

Uncertainty propagation:

sigma_f^2 = sum_i (partial f/partial x_i)^2 sigma_i^2

Stationary action:

delta S = 0

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/mathematical-methods-in-physics
