# Methodology Notes

## Purpose

This repository folder supports an article on cosmology and cosmic history by turning introductory cosmological relations into reproducible computational workflows.

The goal is not to replace precision cosmology packages. The goal is to provide transparent scaffolding for:

- low-redshift Hubble-law intuition
- redshift-scale-factor conversion
- radiation-temperature scaling
- simplified ΛCDM expansion-rate comparison
- cosmic-era metadata
- reproducible cosmological tables

## Core Physical Ideas

### Hubble Relation

v = H0 * d

This relation is useful at low redshift as a first approximation. It is not sufficient for precision high-redshift cosmology.

### Redshift and Scale Factor

a = 1 / (1 + z)

where the present scale factor is normalized to 1.

### Radiation Temperature

T(z) = T0 * (1 + z)

where T0 is the present-day CMB temperature.

### Simplified Flat ΛCDM Expansion

H(z) = H0 * sqrt(Omega_m(1+z)^3 + Omega_r(1+z)^4 + Omega_Lambda)

This simplified form helps show how matter, radiation, and dark energy contribute to the expansion rate across redshift.

## Assumptions

The introductory workflows assume:

- a representative Hubble constant for educational examples
- simplified flat ΛCDM-style expansion
- no curvature term
- no evolving dark-energy equation of state
- no radiation-neutrino subtleties beyond a simple radiation density term
- no full parameter inference or likelihood fitting

## Limitations

These workflows should not be used as production cosmology constraints. They are teaching and scaffolding tools for understanding relationships among redshift, scale factor, expansion, and cosmic history.

## Computational Philosophy

The code is organized by scientific role:

- Python: transparent cosmological tables and expansion-rate calculations
- R: summaries and observational-style tabulation
- Julia: scale-factor and expansion-rate scaffolding
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing table generation
- SQL: structured metadata for cosmic eras and model assumptions
- Rust: safe command-line utility
- C: low-level table calculation
