# Nuclear Physics and the Energetics of the Atomic Nucleus

This folder supports the Physics knowledge-series article **Nuclear Physics and the Energetics of the Atomic Nucleus**.

The article examines nuclear composition, isotopes, nuclear forces, binding energy, mass defect, radioactive decay, half-life, alpha/beta/gamma processes, fission, fusion, nuclear models, nuclear data, and nuclear measurement.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible nuclear-physics workflows.

## Included Materials

- Python workflows for radioactive decay simulation, binding-energy calculation, half-life conversion, and semi-empirical mass-formula scaffolding
- R workflows for decay-curve fitting and isotope-summary tabulation
- Julia isotope binding and decay scaffold
- C++ binding-energy parameter sweep
- Fortran radioactive-decay table generation
- SQL metadata for isotopes, decay modes, nuclear relations, nuclear-data sources, model assumptions, and simulation runs
- Rust command-line utility for half-life and decay constant conversion
- C low-level helium-4 binding-energy example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Mass number:

A = Z + N

Mass-energy relation:

E = m c^2

Binding energy:

B = delta_m c^2

Exponential radioactive decay:

N(t) = N0 exp(-lambda t)

Half-life:

t_1/2 = ln(2) / lambda

Activity:

A_act = lambda N

Semi-empirical mass-formula scaffold:

B(A,Z) = a_v A - a_s A^(2/3) - a_c Z(Z-1)/A^(1/3) - a_a(A-2Z)^2/A + delta(A,Z)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus
