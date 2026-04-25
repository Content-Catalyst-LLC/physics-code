# Symmetry, Law, and the Search for Physical Order

This folder supports the Physics knowledge-series article **Symmetry, Law, and the Search for Physical Order**.

The article examines symmetry as a foundational structure in physics, including invariance, transformation groups, Noether's theorem, conservation laws, space-time symmetry, gauge symmetry, spontaneous symmetry breaking, particle physics, condensed matter, and symmetry violation.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible symmetry-modeling workflows.

## Included Materials

- Python workflows for conserved-energy diagnostics, symmetry-breaking potentials, gauge-phase examples, and simple group actions
- R workflows for reflection invariance summaries and symmetry-breaking comparison
- Julia Noether-style energy conservation checks
- C++ parameter sweeps for symmetric and symmetry-broken potentials
- Fortran conservation-table generation
- SQL metadata for symmetry types, physical relations, conservation laws, model assumptions, source notes, and simulation runs
- Rust command-line utility for double-well potential minima
- C low-level harmonic-oscillator energy example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Action:

S = ∫ L(q, qdot, t) dt

Time-independent energy-like conserved quantity:

E = qdot * ∂L/∂qdot - L

Conserved current:

∂_mu j^mu = 0

Local phase transformation:

psi(x) -> exp(i alpha(x)) psi(x)

Covariant derivative:

D_mu = ∂_mu + i q A_mu

Symmetric double-well potential:

V(x) = -a x^2 + b x^4

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/symmetry-law-and-the-search-for-physical-order
