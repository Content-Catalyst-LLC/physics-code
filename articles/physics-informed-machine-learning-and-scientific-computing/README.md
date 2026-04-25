# Physics-Informed Machine Learning and Scientific Computing

This folder supports the Physics knowledge-series article **Physics-Informed Machine Learning and Scientific Computing**.

The article examines physics-informed neural networks, scientific machine learning, neural ordinary differential equations, universal differential equations, differentiable simulators, neural operators, Fourier neural operators, DeepONets, surrogate modeling, reduced-order modeling, inverse problems, data assimilation, conservation constraints, dimensional analysis, PDE residual losses, automatic differentiation, adjoint sensitivity, uncertainty quantification, identifiability, optimization pathologies, verification, validation, reproducibility, and scientific software workflows.

## Repository Purpose

This folder provides computational scaffolding for extending the article's selected examples into reproducible physics-informed machine learning and scientific computing workflows.

## Included Materials

- Python workflows for PINN training, residual diagnostics, inverse parameter estimation, neural ODE scaffolds, operator-learning dataset generation, and conservation checks
- R workflows for residual diagnostics and scientific ML audit tables
- Julia SciML-style scaffolding
- C++ residual parameter sweeps
- Fortran finite-difference baselines
- SQL metadata for physical models, training data, collocation points, losses, assumptions, sources, and runs
- Rust command-line utility for residual scoring and nondimensional diagnostics
- C low-level residual examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Physical operator equation:

N[u; lambda] = 0

Neural field approximation:

u_theta(x,t)

Physics residual:

r_theta(x,t) = N[u_theta; lambda](x,t)

PDE residual loss:

L_r = (1/N_r) sum_i |r_theta(x_i,t_i)|^2

Data loss:

L_d = (1/N_d) sum_j |u_theta(x_j,t_j) - y_j|^2

Total PINN loss:

L = lambda_r L_r + lambda_b L_b + lambda_i L_i + lambda_d L_d

Neural ODE:

dx/dt = f_theta(x,t)

Universal differential equation:

dx/dt = f_known(x,t; alpha) + g_theta(x,t)

Operator learning map:

G_theta: a(x) -> u(x,t)

Bayesian posterior:

p(theta,lambda|y) proportional to p(y|theta,lambda) p(theta,lambda)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/physics-informed-machine-learning-and-scientific-computing
