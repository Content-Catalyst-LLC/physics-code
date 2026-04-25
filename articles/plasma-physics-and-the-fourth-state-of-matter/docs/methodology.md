# Methodology Notes

## Purpose

This repository folder supports an article on plasma physics by translating Debye shielding, plasma frequency, gyrofrequency, gyroradius, plasma beta, Alfvén speed, charged-particle motion, magnetic confinement scales, and plasma diagnostics metadata into reproducible computational workflows.

The goal is not to replace production plasma simulation software, particle-in-cell codes, MHD solvers, gyrokinetic codes, fusion-device modeling platforms, or laboratory diagnostic pipelines. The goal is to provide transparent scaffolding for:

- Debye length
- Debye sphere particle number
- electron plasma frequency
- ion plasma frequency
- electron and ion gyrofrequency
- Larmor radius
- Alfvén speed
- plasma beta
- Lorentz-force particle orbit integration
- parameter sweeps
- plasma regime metadata
- diagnostic metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Debye Shielding

lambda_D = sqrt(epsilon_0 kB Te / (ne e^2))

### Plasma Frequency

omega_pe = sqrt(ne e^2 / (epsilon_0 me))

### Cyclotron Motion

Omega_c = |q|B/m

r_L = m v_perp/(|q|B)

### Magnetized Plasma

v_A = B/sqrt(mu_0 rho)

beta = 2 mu_0 p/B^2

### Lorentz Force

m dv/dt = q(E + v x B)

## Assumptions

The introductory workflows assume:

- SI units
- quasi-neutral electron-ion plasma where stated
- electron temperature supplied in eV for parameter workflows
- singly ionized ions unless otherwise stated
- ideal uniform magnetic field for orbit integration
- no self-consistent field solve in the single-particle example
- no collisions unless explicitly modeled
- no relativistic corrections in introductory scripts
- no full MHD or kinetic solver in introductory scripts
- no production fusion-device geometry

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for PIC simulation, gyrokinetic simulation, extended MHD modeling, fusion transport codes, sheath-resolved low-temperature plasma models, laboratory diagnostic calibration, or validated fusion design software.

## Computational Philosophy

The code is organized by scientific role:

- Python: Lorentz-force integration, plasma parameter diagnostics, parameter sweeps
- R: sensitivity tables and reproducible summaries
- Julia: compact plasma calculations
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing plasma tables
- SQL: structured metadata for regimes, constants, diagnostics, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
