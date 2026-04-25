# Methodology Notes

## Purpose

This repository folder supports an article on atomic, molecular, and optical physics by translating hydrogen spectra, photon energy conversion, molecular rotational populations, two-level optical driving, spectral line fitting, and AMO metadata into reproducible computational workflows.

The goal is not to replace high-precision atomic structure codes, quantum chemistry packages, molecular spectroscopy databases, density-matrix solvers, or full quantum-optics simulation libraries. The goal is to provide transparent scaffolding for:

- hydrogenic spectral calculations
- wavelength, frequency, energy, and wavenumber conversion
- molecular rotational energy tables
- Boltzmann state populations
- ideal two-level Rabi oscillations
- Gaussian spectral line fitting
- AMO constants and units
- transition metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Photon Relations

E = h nu

c = lambda nu

E = h c / lambda

### Hydrogen Spectra

1/lambda = R_H(1/n_lower^2 - 1/n_upper^2)

### Rotational Energies

E_J = B J(J + 1)

### Vibrational Energies

E_v = hbar omega(v + 1/2)

### Thermal Populations

N_i/N_j = (g_i/g_j) exp[-(E_i - E_j)/(k_B T)]

### Rabi Oscillations

Omega_R = sqrt(Omega^2 + Delta^2)

P_e(t) = [Omega^2/Omega_R^2] sin^2(Omega_R t/2)

## Assumptions

The introductory workflows assume:

- SI units unless otherwise stated
- hydrogen-like spectral calculations without fine, hyperfine, Lamb, or isotope corrections
- approximate constants for educational computation
- rigid-rotor molecular spectra
- harmonic-oscillator vibrational scaffolding
- ideal coherent two-level Rabi dynamics
- Gaussian spectral line fitting for demonstration
- no full density-matrix decoherence model in introductory scripts
- no high-precision atomic structure calculation
- no production spectroscopic database replacement

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for NIST reference databases, quantum chemistry software, high-precision AMO calculations, laboratory-grade line-shape analysis, or validated instrument pipelines.

## Computational Philosophy

The code is organized by scientific role:

- Python: spectral calculations, Rabi dynamics, fitting scaffolds, unit conversion
- R: Boltzmann population tables, spectral summaries, reproducible reporting
- Julia: compact AMO calculations
- C++: performance-oriented spectral sweeps
- Fortran: classic scientific-computing transition tables
- SQL: structured metadata for states, transitions, constants, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
