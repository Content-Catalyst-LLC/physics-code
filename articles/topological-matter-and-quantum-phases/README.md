# Topological Matter and Quantum Phases

This folder supports the Physics knowledge-series article **Topological Matter and Quantum Phases**.

The article examines topology in physics, adiabatic deformation, energy gaps, Berry phase, Berry curvature, Chern numbers, quantum Hall effects, fractional quantum Hall fluids, anyons, topological insulators, topological superconductors, Majorana modes, symmetry-protected topological phases, intrinsic topological order, bulk-boundary correspondence, edge and surface states, topological phase transitions, band topology, interacting topology, disorder, entanglement, and computational topology workflows.

## Repository Purpose

This folder provides computational scaffolding for extending the article's selected examples into reproducible topological-matter and quantum-phase workflows.

## Included Materials

- Python workflows for two-band Chern numbers, Berry curvature, Wilson-loop scaffolds, edge-state toy models, and Kitaev-chain diagnostics
- R workflows for SSH winding numbers and topological parameter sweeps
- Julia band-topology calculation scaffolding
- C++ Chern-model parameter sweeps
- Fortran winding-number tables
- SQL metadata for models, invariants, symmetries, parameters, assumptions, sources, and runs
- Rust command-line utility for SSH winding and Chern phase labels
- C low-level winding-number examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Berry connection:

A_n(k) = i <u_n(k)|grad_k u_n(k)>

Berry curvature:

Omega_n(k) = partial_kx A_y - partial_ky A_x

Chern number:

C = (1/2pi) integral_BZ Omega(k) d^2k

Two-band Chern number:

C = (1/4pi) integral d_hat dot (partial_kx d_hat cross partial_ky d_hat) d^2k

SSH off-diagonal function:

q(k) = t1 + t2 exp(-ik)

SSH winding number:

nu = (1/2pi i) integral dk d/dk log q(k)

Hall conductance:

sigma_xy = C e^2/h

Majorana condition:

gamma dagger = gamma

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/topological-matter-and-quantum-phases
