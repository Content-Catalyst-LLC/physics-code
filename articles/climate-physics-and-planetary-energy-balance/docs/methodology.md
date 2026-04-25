# Methodology Notes

## Purpose

This repository folder supports an article on climate physics and planetary energy balance by translating radiation balance, albedo sensitivity, greenhouse forcing, feedback parameters, ocean heat uptake, and reduced energy-balance models into reproducible computational workflows.

The goal is not to replace comprehensive Earth system models, radiative transfer codes, general circulation models, satellite products, or climate assessment workflows. The goal is to provide transparent scaffolding for:

- absorbed shortwave radiation
- effective emission temperature
- approximate CO2 radiative forcing
- equilibrium warming response
- one-layer transient energy-balance response
- two-layer ocean heat uptake
- albedo sensitivity
- feedback sensitivity
- uncertainty propagation
- climate-physics metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Radiation Balance

ASR = S0(1 - alpha)/4

OLR = sigma T^4

N = ASR - OLR

### Effective Emission Temperature

Te = [S0(1 - alpha)/(4 sigma)]^(1/4)

### Radiative Forcing

DeltaF = 5.35 ln(C/C0)

### Feedback and Sensitivity

N = F - lambda DeltaT

DeltaT_eq = F/lambda

### One-Layer Model

C dT/dt = F(t) - lambda T

### Two-Layer Model

Cu dTu/dt = F(t) - lambda Tu - kappa(Tu - Td)

Cd dTd/dt = kappa(Tu - Td)

## Assumptions

The introductory workflows assume:

- globally averaged reduced energy-balance models
- SI units
- fixed or prescribed albedo in simple examples
- approximate logarithmic CO2 forcing
- linear feedback parameter
- prescribed heat capacities
- idealized forcing scenarios
- no spatially resolved atmosphere or ocean dynamics
- no cloud microphysics
- no aerosol-cloud interaction model
- no comprehensive radiative transfer calculation
- no formal Earth system model calibration

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for comprehensive climate models, observational reanalysis products, satellite radiation datasets, full line-by-line radiative transfer, or formal climate attribution studies.

## Computational Philosophy

The code is organized by scientific role:

- Python: transient energy-balance models, two-layer heat uptake, scenario integration, Monte Carlo uncertainty
- R: parameter tables, sensitivity summaries, equilibrium response
- Julia: compact climate-response calculations
- C++: performance-oriented parameter sweeps
- Fortran: classic radiation-balance tables
- SQL: structured metadata for variables, relations, scenarios, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
