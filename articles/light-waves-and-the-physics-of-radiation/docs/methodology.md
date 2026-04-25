# Methodology Notes

## Purpose

This repository folder supports an article on light, waves, and radiation by translating core optical, electromagnetic, and thermal-radiation relations into reproducible computational workflows.

The goal is not to replace optical design software, radiative-transfer codes, electromagnetic simulation packages, or calibrated spectrometer pipelines. The goal is to provide transparent scaffolding for:

- wavelength-frequency-energy conversion
- wave relation tables
- double-slit interference
- diffraction-envelope exploration
- Planck spectral radiance
- Wien peak estimation
- Stefan-Boltzmann flux scaling
- spectral-band metadata
- radiation-law source provenance
- reproducibility documentation

## Core Ideas

### Wave Relation

v = f lambda

For electromagnetic radiation in vacuum:

c = f lambda

### Double-Slit Interference

Bright fringes satisfy:

Delta = m lambda

For small angles:

y_m = m lambda L / d

### Planck Spectral Radiance

B_lambda(T) = (2 h c^2 / lambda^5) / [exp(h c / (lambda k_B T)) - 1]

### Wien Displacement Law

lambda_max T = b

### Stefan-Boltzmann Law

M = sigma T^4

### Photon Energy

E = h f = h c / lambda

## Assumptions

The introductory workflows assume:

- idealized monochromatic or blackbody sources
- simplified double-slit geometry
- far-field/small-angle approximations where stated
- no detector-response calibration unless extended separately
- no atmospheric absorption unless added separately
- no full radiative-transfer calculation
- no polarization-resolved full Maxwell solver
- no optical aberration model
- no quantum-field treatment of radiation

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for professional radiometry software, electromagnetic finite-difference time-domain simulation, optical design packages, spectrometer calibration, or atmospheric radiative-transfer models.

## Computational Philosophy

The code is organized by scientific role:

- Python: interference models, Planck curves, spectral-band metadata, numerical modeling
- R: tabular summaries, spectrum comparisons, uncertainty-ready data analysis
- Julia: compact high-performance spectral-radiance scaffolding
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing table generation
- SQL: structured metadata for spectra, constants, models, assumptions, and source provenance
- Rust: safe command-line utility
- C: low-level radiation-law calculation
