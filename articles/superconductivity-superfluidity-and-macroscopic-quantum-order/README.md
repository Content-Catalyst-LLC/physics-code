# Superconductivity, Superfluidity, and Macroscopic Quantum Order

This folder supports the Physics knowledge-series article **Superconductivity, Superfluidity, and Macroscopic Quantum Order**.

The article examines superconductivity, superfluidity, broken U(1) symmetry, complex order parameters, phase coherence, Cooper pairs, BCS theory, Ginzburg-Landau theory, London equations, Meissner effect, coherence length, penetration depth, type-I and type-II superconductivity, flux quantization, Abrikosov vortices, Josephson effects, Bose-Einstein condensation, helium-4 superfluidity, helium-3 paired-fermion superfluidity, Landau's criterion, quantized circulation, two-fluid behavior, unconventional superconductivity, quantum fluids, and macroscopic quantum devices.

## Repository Purpose

This folder provides computational scaffolding for extending the article's selected examples into reproducible macroscopic-quantum-order workflows.

## Included Materials

- Python workflows for Josephson junction dynamics, Ginzburg-Landau free energy, flux quantization, superfluid vortex phase fields, and BCS gap approximations
- R workflows for Ginzburg-Landau free-energy landscapes and order-parameter summaries
- Julia order-parameter calculation scaffolding
- C++ phase and flux sweeps
- Fortran free-energy tables
- SQL metadata for superconductivity, superfluidity, materials, observables, assumptions, sources, and runs
- Rust command-line utility for flux and Josephson calculations
- C low-level free-energy examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Order parameter:

Psi = |Psi| exp(i theta)

Ginzburg-Landau free-energy density:

f = alpha |Psi|^2 + beta/2 |Psi|^4

Equilibrium amplitude:

|Psi_0|^2 = -alpha/beta

London penetration depth:

lambda_L = sqrt(m*/(mu0 n_s q^2))

Coherence length:

xi = sqrt(hbar^2/(2 m* |alpha|))

Ginzburg-Landau parameter:

kappa = lambda/xi

Flux quantum:

Phi_0 = h/(2e)

Josephson current:

I = I_c sin(phi)

Josephson phase-voltage relation:

dphi/dt = 2eV/hbar

Superfluid velocity:

v_s = (hbar/m) grad theta

Quantized circulation:

Integral v_s dot dl = n h/m

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/superconductivity-superfluidity-and-macroscopic-quantum-order
