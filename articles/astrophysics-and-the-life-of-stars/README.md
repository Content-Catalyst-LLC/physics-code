# Astrophysics and the Life of Stars

This folder supports the Physics knowledge-series article **Astrophysics and the Life of Stars**.

The article examines star formation, hydrostatic equilibrium, fusion, the Hertzsprung-Russell diagram, main-sequence scaling, stellar death, compact remnants, and nucleosynthesis.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible stellar astrophysics workflows.

## Included Materials

- Python workflows for mass-luminosity scaling, lifetime scaling, H-R-style sequences, and stellar radius estimation
- R workflows for H-R diagram summaries and observational-style tabulation
- Julia hydrostatic-equilibrium toy model
- C++ stellar parameter sweep
- Fortran stellar scaling table generation
- SQL metadata for stellar classes, evolutionary stages, model assumptions, source notes, and simulation runs
- Rust command-line utility for mass-luminosity and lifetime scaling
- C low-level stellar scaling example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Hydrostatic equilibrium:

dP/dr = -G M(r) rho(r) / r^2

Mass continuity:

dM/dr = 4 pi r^2 rho(r)

Stefan-Boltzmann luminosity:

L = 4 pi R^2 sigma T_eff^4

Approximate main-sequence mass-luminosity scaling:

L / L_sun = (M / M_sun)^3.5

Approximate main-sequence lifetime scaling:

t / t_sun = M / L

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/astrophysics-and-the-life-of-stars
