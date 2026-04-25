# Path Integrals and the Functional Formulation of Physics

This folder supports the Physics knowledge-series article **Path Integrals and the Functional Formulation of Physics**.

The article examines propagators, amplitudes, classical action, stationary phase, time slicing, configuration-space path integrals, phase-space path integrals, Euclidean continuation, partition functions, Gaussian functional integrals, generating functionals, source terms, correlation functions, Wick's theorem, perturbation theory, Feynman diagrams, effective actions, saddle-point methods, instantons, fermionic Grassmann integrals, gauge fixing, lattice path integrals, Monte Carlo sampling, and the conceptual limits of functional methods.

## Repository Purpose

This folder provides advanced computational scaffolding for extending the article's selected examples into reproducible path-integral and functional-method workflows.

## Included Materials

- Python workflows for Euclidean harmonic oscillator Monte Carlo sampling, discretized path actions, Gaussian integrals, generating-functional scaffolds, correlation estimation, lattice scalar fields, and stochastic paths
- R workflows for discretized Euclidean actions and path-action summaries
- Julia path-integral calculation scaffolding
- C++ Euclidean-action sweeps
- Fortran discretized-action tables
- SQL metadata for actions, path-integral models, discretization choices, assumptions, sources, and simulation runs
- Rust command-line utility for Euclidean action calculations
- C low-level discretized path-action examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Classical action:

S[q] = integral L(q, qdot, t) dt

Stationary action:

delta S = 0

Quantum propagator:

K(q_f,t_f;q_i,t_i) = integral Dq exp(i S[q]/hbar)

Phase-space path integral:

K = integral Dp Dq exp((i/hbar) integral (p qdot - H) dt)

Euclidean path integral:

Z = integral Dq exp(-S_E[q]/hbar)

Generating functional:

Z[J] = integral Dphi exp((i/hbar)(S[phi] + integral J phi))

Correlation functions:

G_n = functional derivatives of Z[J] with respect to J

Euclidean harmonic oscillator action:

S_E = sum_n [m/(2 Delta tau)(x_{n+1}-x_n)^2 + Delta tau/2 m omega^2 x_n^2]

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/path-integrals-and-the-functional-formulation-of-physics
