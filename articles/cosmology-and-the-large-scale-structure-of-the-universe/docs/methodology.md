# Methodology Notes

## Purpose

This repository folder supports an article on cosmology and large-scale structure by translating FLRW expansion, distance-redshift relations, linear growth approximations, toy matter power spectra, BAO scale relations, survey metadata, simulation metadata, and source provenance into reproducible computational workflows.

The goal is not to replace professional Boltzmann solvers, survey likelihoods, N-body simulation codes, hydrodynamic simulation frameworks, Bayesian inference pipelines, or validated cosmological parameter tools. The goal is to provide transparent scaffolding for:

- background expansion
- redshift-scale-factor conversions
- Hubble parameter tables
- comoving, luminosity, and angular diameter distances
- approximate linear growth factors
- toy matter power spectra
- BAO-scale relations
- survey and observable metadata
- simulation summary tables
- source provenance and reproducibility documentation

## Core Ideas

### Scale Factor and Redshift

a = 1/(1+z)

### Expansion Function

E(z) = H(z)/H0

### Flat Lambda-CDM

E(z) = sqrt(Omega_m(1+z)^3 + Omega_Lambda)

### Comoving Distance

chi(z) = c/H0 integral_0^z dz'/E(z')

### Luminosity Distance

D_L = (1+z) chi

### Angular Diameter Distance

D_A = chi/(1+z)

### Density Contrast

delta = (rho - rho_bar)/rho_bar

### Matter Power Spectrum

P(k) describes variance of Fourier-space density contrast.

## Assumptions

The introductory workflows assume:

- spatial flatness unless stated otherwise
- late-time distance calculations with radiation neglected
- H0 in km/s/Mpc
- distances in Mpc
- toy growth-index approximation for linear growth
- toy transfer function and BAO wiggles for educational spectra
- no Boltzmann solver
- no nonlinear matter power-spectrum correction
- no survey likelihood or covariance modeling

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for CAMB, CLASS, Astropy Cosmology, CosmoSIS, Cobaya, MontePython, AbacusSummit, Gadget, Enzo, RAMSES, AREPO, or validated survey-analysis pipelines.

## Computational Philosophy

The code is organized by scientific role:

- Python: expansion, distances, growth, toy spectra, survey/simulation metadata
- R: distance tables and parameter summaries
- Julia: compact cosmology calculations
- C++: performance-oriented distance sweeps
- Fortran: classic scientific-computing expansion tables
- SQL: structured metadata for cosmology, surveys, simulations, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
