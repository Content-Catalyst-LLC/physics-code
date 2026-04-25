# Statistical Physics and the Emergence of Macroscopic Order

This folder supports the Physics knowledge-series article **Statistical Physics and the Emergence of Macroscopic Order**.

The article examines microstates, macrostates, multiplicity, ensembles, entropy, partition functions, fluctuation-response relations, Brownian motion, phase transitions, order parameters, typicality, and the statistical arrow of time.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible statistical-physics workflows.

## Included Materials

- Python workflows for exact two-state macrostate distributions, partition functions, Monte Carlo sampling, fluctuation summaries, and Ising-style lattice scaffolding
- R workflows for macrostate distributions, fluctuation scaling, and ensemble summaries
- Julia Ising-style lattice Monte Carlo scaffold
- C++ exact enumeration and macrostate parameter sweeps
- Fortran two-state partition-function table generation
- SQL metadata for ensembles, constants, state models, source notes, model assumptions, and simulation runs
- Rust command-line utility for two-state distribution summaries
- C low-level two-state partition-function example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Boltzmann entropy:

S = k_B ln W

Inverse thermal energy:

beta = 1 / (k_B T)

Canonical probability:

P_i = exp(-beta E_i) / Z

Partition function:

Z = sum_i exp(-beta E_i)

Helmholtz free energy:

F = -k_B T ln Z

Mean energy:

<E> = - partial ln Z / partial beta

Energy fluctuation relation:

<Delta E^2> = k_B T^2 C_V

Two-state partition function:

Z = 1 + exp(-beta epsilon)

Two-state excited probability:

P_exc = exp(-beta epsilon) / [1 + exp(-beta epsilon)]

Two-state multiplicity:

W(n) = N! / [n!(N-n)!]

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/statistical-physics-and-the-emergence-of-macroscopic-order
