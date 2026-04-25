# Condensed Matter and the Physics of Materials

This folder supports the Physics knowledge-series article **Condensed Matter and the Physics of Materials**.

The article examines crystal structure, electronic bands, phonons, transport, semiconductors, defects, magnetism, superconductivity, topological materials, standards, materials data, and computational materials workflows.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible condensed-matter and materials-physics workflows.

## Included Materials

- Python workflows for free-electron dispersion, tight-binding bands, phonon-style dispersion, and band-gap classification
- R workflows for metallic and semiconductor-like transport summaries
- Julia tight-binding and lattice-dispersion scaffold
- C++ transport and band-gap parameter sweeps
- Fortran phonon-dispersion table generation
- SQL metadata for materials, phases, transport measurements, band gaps, defects, model assumptions, source notes, and simulation runs
- Rust command-line utility for band-gap classification
- C low-level resistivity-temperature table example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Bloch form:

psi_k(r) = exp(i k dot r) u_k(r)

Free-electron-like dispersion:

E(k) = hbar^2 k^2 / 2m

One-dimensional tight-binding dispersion:

E(k) = E0 - 2t cos(ka)

One-dimensional phonon-style dispersion:

omega(k) = 2 sqrt(K/M) |sin(ka/2)|

Intrinsic semiconductor carrier trend:

n_i proportional to exp[-E_g/(2 k_B T)]

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/condensed-matter-and-the-physics-of-materials
