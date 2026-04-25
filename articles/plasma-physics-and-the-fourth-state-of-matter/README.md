# Plasma Physics and the Fourth State of Matter

This folder supports the Physics knowledge-series article **Plasma Physics and the Fourth State of Matter**.

The article examines ionization, quasi-neutrality, Debye shielding, plasma frequency, charged-particle motion, gyrofrequency, gyroradius, drifts, fluid models, kinetic models, magnetohydrodynamics, plasma waves, Alfvén waves, Langmuir waves, instabilities, turbulence, fusion plasmas, magnetic confinement, inertial confinement, space plasmas, astrophysical plasmas, low-temperature plasmas, industrial plasma systems, diagnostics, and computational plasma modeling.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible plasma-physics workflows.

## Included Materials

- Python workflows for Lorentz-force integration, Debye length, plasma frequency, gyrofrequency, gyroradius, Alfvén speed, plasma beta, and parameter sweeps
- R workflows for plasma parameter sensitivity, Debye shielding diagnostics, and magnetic-confinement summaries
- Julia plasma calculation scaffolding
- C++ plasma parameter sweeps
- Fortran plasma frequency and Debye length tables
- SQL metadata for plasma constants, regimes, diagnostics, relations, assumptions, sources, and simulation runs
- Rust command-line utility for plasma parameters
- C low-level Debye length and plasma frequency examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Debye length:

lambda_D = sqrt(epsilon_0 kB Te / (ne e^2))

Electron plasma frequency:

omega_pe = sqrt(ne e^2 / (epsilon_0 me))

Cyclotron frequency:

Omega_c = |q|B/m

Larmor radius:

r_L = m v_perp/(|q|B)

Thermal speed:

v_th = sqrt(kB T/m)

Alfven speed:

v_A = B/sqrt(mu_0 rho)

Plasma beta:

beta = 2 mu_0 p / B^2

Lorentz force:

m dv/dt = q(E + v x B)

E cross B drift:

v_E = E x B / B^2

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/plasma-physics-and-the-fourth-state-of-matter
