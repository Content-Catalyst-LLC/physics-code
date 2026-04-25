# Methodology Notes

## Purpose

This repository folder supports an article on condensed matter and materials physics by turning central materials concepts into reproducible computational workflows.

The goal is not to replace density-functional theory, molecular dynamics, many-body solvers, or experimental materials databases. The goal is to provide transparent scaffolding for:

- transport-curve comparison
- free-electron dispersion
- tight-binding band models
- phonon-style dispersion
- band-gap classification
- materials metadata
- standards and measurement-data structures
- reproducible materials workflows

## Core Ideas

### Bloch Form

psi_k(r) = exp(i k dot r) u_k(r)

where u_k(r) has the periodicity of the lattice.

### Free-Electron-Like Dispersion

E(k) = hbar^2 k^2 / 2m

This provides a simple starting point for metallic behavior.

### Tight-Binding Dispersion

E(k) = E0 - 2t cos(ka)

This provides a simple lattice-based band model.

### Phonon-Style Dispersion

omega(k) = 2 sqrt(K/M) |sin(ka/2)|

This is a simple one-dimensional lattice-vibration model.

### Band-Gap Classification

A simplified materials classifier may treat:

- E_g = 0 eV as metal-like
- small E_g as semiconductor-like
- large E_g as insulator-like

Real classification depends on more than band gap alone.

## Assumptions

The workflows assume:

- one-dimensional toy models
- educational parameter values
- simple metallic and semiconductor-like transport curves
- arbitrary units unless explicitly stated
- no first-principles electronic-structure calculation
- no electron-phonon interaction model
- no many-body correlation solver
- no materials-specific uncertainty model unless added separately

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for calibrated materials-property measurements, density-functional theory, many-body calculations, validated transport modeling, or production materials informatics.

## Computational Philosophy

The code is organized by scientific role:

- Python: band dispersion, phonon dispersion, band-gap classification
- R: transport summaries and materials property comparison
- Julia: compact lattice and tight-binding scaffolding
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing table generation
- SQL: structured metadata for materials, measurements, phases, and sources
- Rust: safe command-line utility
- C: low-level transport table calculation
