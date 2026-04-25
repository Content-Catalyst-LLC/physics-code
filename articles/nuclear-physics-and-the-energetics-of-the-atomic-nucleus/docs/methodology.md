# Methodology Notes

## Purpose

This repository folder supports an article on nuclear physics by turning introductory nuclear-structure and nuclear-decay relations into reproducible computational workflows.

The goal is not to replace evaluated nuclear-data libraries, reactor-analysis software, radiation-transport codes, or nuclear-structure solvers. The goal is to provide transparent scaffolding for:

- nuclear composition
- isotope metadata
- radioactive decay curves
- half-life fitting
- binding-energy calculation
- binding energy per nucleon
- semi-empirical mass-formula intuition
- reproducible nuclear-data structures

## Core Ideas

### Composition

A = Z + N

where:

- Z is proton number
- N is neutron number
- A is mass number

### Binding Energy

B = delta_m c^2

When masses are expressed in atomic mass units:

B_MeV = delta_m_u * 931.49410242

### Radioactive Decay

N(t) = N0 exp(-lambda t)

### Half-Life

t_1/2 = ln(2) / lambda

### Activity

A_act = lambda N

### Semi-Empirical Mass Formula

B(A,Z) = a_v A - a_s A^(2/3) - a_c Z(Z-1)/A^(1/3) - a_a(A-2Z)^2/A + delta(A,Z)

This scaffold illustrates broad binding-energy trends and should not be treated as a precision nuclear-mass model.

## Assumptions

The introductory workflows assume:

- simplified isotope examples
- approximate educational nuclear masses where used
- exponential single-isotope decay without daughter buildup in article-level examples
- no radiation-transport calculation
- no reactor-physics criticality calculation
- no shielding calculation
- no nuclear-weapons design calculation
- no production optimization
- no dose calculation unless added separately under appropriate safety constraints

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for evaluated nuclear-data libraries, validated radiation-metrology procedures, licensed nuclear-engineering analysis, medical physics planning, or regulatory compliance.

## Computational Philosophy

The code is organized by scientific role:

- Python: decay simulation, binding energy, semi-empirical mass-formula scaffolds
- R: decay fitting, isotope summaries, tabular comparison
- Julia: compact isotope and decay calculations
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing decay tables
- SQL: structured metadata for nuclear quantities, isotopes, decay modes, and sources
- Rust: safe command-line utility
- C: low-level binding-energy calculation
