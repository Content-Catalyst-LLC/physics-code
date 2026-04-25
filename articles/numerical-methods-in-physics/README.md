# Numerical Methods in Physics

This folder supports the Physics knowledge-series article **Numerical Methods in Physics**.

The article examines discretization, truncation error, roundoff error, convergence, consistency, stability, conditioning, nondimensionalization, finite differences, finite volumes, finite elements, spectral methods, numerical quadrature, root finding, interpolation, ordinary differential equation solvers, symplectic integrators, partial differential equation methods, sparse linear systems, eigenvalue problems, Monte Carlo methods, stochastic simulation, optimization, inverse problems, verification, validation, uncertainty quantification, reproducible computational workflows, and scientific software design.

## Repository Purpose

This folder provides computational scaffolding for extending the article's selected examples into reproducible numerical-methods workflows for physics.

## Included Materials

- Python workflows for finite difference convergence, heat-equation stability, ODE integrator comparison, sparse Poisson solvers, eigenvalue methods, and Monte Carlo estimation
- R workflows for derivative convergence studies and error summaries
- Julia numerical-method scaffolding
- C++ finite-difference parameter sweeps
- Fortran convergence tables
- SQL metadata for methods, parameters, numerical assumptions, verification tests, sources, and simulation runs
- Rust command-line utility for finite-difference and stability calculations
- C low-level derivative convergence examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Central difference derivative:

u'(x_i) ≈ [u_{i+1} - u_{i-1}] / (2 dx)

Second derivative:

u''(x_i) ≈ [u_{i+1} - 2u_i + u_{i-1}] / dx^2

Error order:

E ≈ C dx^p

Condition number:

kappa(A) = ||A|| ||A^{-1}||

ODE initial value problem:

dy/dt = f(t,y)

Forward Euler:

y_{n+1} = y_n + dt f(t_n,y_n)

Heat equation:

partial u / partial t = D partial^2 u / partial x^2

Explicit heat-equation update:

u_i^{n+1} = u_i^n + r(u_{i+1}^n - 2u_i^n + u_{i-1}^n)

Diffusion stability number:

r = D dt / dx^2

Standard explicit 1D heat-equation stability condition:

r <= 1/2

Monte Carlo error:

E_MC ~ sigma_f / sqrt(N)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/numerical-methods-in-physics
