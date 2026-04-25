# Methodology Notes

## Purpose

This repository folder supports an article on scattering theory, cross sections, and physical inference by translating scattering amplitudes, angular distributions, cross-section integration, resonance fitting, Born approximation examples, partial-wave phase shifts, event-rate inference, detector smearing, and metadata provenance into reproducible computational workflows.

The goal is not to replace professional scattering packages, particle-physics event generators, detector simulation frameworks, neutron or X-ray scattering analysis tools, nuclear reaction codes, or validated high-energy physics likelihood pipelines. The goal is to provide transparent scaffolding for:

- angular differential cross-section integration
- total cross-section calculation
- Born approximation examples
- partial-wave phase-shift contributions
- optical-theorem consistency checks
- Breit-Wigner resonance fitting
- event-rate inference
- detector response and smearing
- source provenance
- reproducibility documentation

## Assumptions

The introductory workflows assume:

- simplified scalar angular distributions
- natural or dimensionless units unless specified
- simple Breit-Wigner resonance models
- Gaussian measurement noise for teaching fits
- Poisson counting for event-rate examples
- simple detector smearing rather than full simulation
- no full quantum field theory matrix-element generator
- no production unfolding framework

## Computational Philosophy

The code is organized by scientific role:

- Python: resonance fitting, angular integration, Born approximation, phase shifts, event rates, detector response
- R: transparent cross-section tables and integration checks
- Julia: compact scattering calculations
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for models, assumptions, sources, and inference runs
- Rust: safe command-line utility
- C: low-level numerical calculations
