# Phase Transitions, Critical Phenomena, and the Renormalization Group

This folder supports the Physics knowledge-series article **Phase Transitions, Critical Phenomena, and the Renormalization Group**.

The article examines phases, order parameters, symmetry breaking, first-order and continuous transitions, free-energy landscapes, Landau theory, the Ising model, fluctuations, correlation functions, correlation length, susceptibility, critical exponents, scaling, universality, finite-size scaling, coarse graining, fixed points, relevant and irrelevant operators, the renormalization group, effective theory, and computational modeling of critical behavior.

## Repository Purpose

This folder provides advanced computational scaffolding for extending the article's selected examples into reproducible critical-phenomena workflows.

## Included Materials

- Python workflows for 2D Ising Monte Carlo simulation, Binder cumulants, finite-size scaling, correlation functions, critical-exponent fitting, and RG toy maps
- R workflows for Landau free energy, equilibrium order parameters, and scaling tables
- Julia critical-phenomena calculation scaffolding
- C++ Ising temperature sweeps
- Fortran finite-size and Landau tables
- SQL metadata for phase-transition models, exponents, universality classes, assumptions, sources, and simulation runs
- Rust command-line utility for Landau and scaling calculations
- C low-level Landau and Ising-scale examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Partition function:

Z = sum exp(-beta H)

Free energy:

F = -k_B T ln Z

Reduced temperature:

t = (T - Tc)/Tc

Ising Hamiltonian:

H = -J sum_<i,j> s_i s_j - h sum_i s_i

Magnetization:

m = (1/N) sum_i s_i

Correlation length:

xi ~ |t|^-nu

Order parameter scaling:

m ~ (-t)^beta

Susceptibility scaling:

chi ~ |t|^-gamma

Landau free energy:

f(m) = f0 + a(T - Tc)m^2 + b m^4

RG eigenvalue scaling:

u_i' = b^y_i u_i

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/phase-transitions-critical-phenomena-and-the-renormalization-group
