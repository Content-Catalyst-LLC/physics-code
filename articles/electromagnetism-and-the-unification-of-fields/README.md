# Electromagnetism and the Unification of Fields

This folder supports the Physics knowledge-series article **Electromagnetism and the Unification of Fields**.

The article examines electric charge, electric fields, potentials, Gauss's law, magnetic fields, moving charge, induction, Maxwell's equations, electromagnetic radiation, energy flux, material response, field theory, electromagnetic units, and measurement standards.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible electromagnetism workflows.

## Included Materials

- Python workflows for electric potential grids, electric field recovery, dipole superposition, finite-difference Laplace scaffolding, and Maxwell-wave relations
- R workflows for point-charge fields, electric potential, wire magnetic fields, and residual analysis against measured values
- Julia finite-difference Laplace-equation scaffold
- C++ Coulomb-field and Lorentz-force parameter sweeps
- Fortran electric-field and potential table generation
- SQL metadata for constants, fields, materials, Maxwell relations, source notes, model assumptions, and simulation runs
- Rust command-line utility for point-charge and wire-field calculations
- C low-level Coulomb-field example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Coulomb field:

E(r) = q / (4 pi epsilon_0 r^2)

Electric potential:

V(r) = q / (4 pi epsilon_0 r)

Electric field from potential:

E = -grad V

Lorentz force:

F = q(E + v x B)

Faraday induction:

integral E dot dl = - d Phi_B / dt

Poynting vector:

S = E x H = (1/mu_0) E x B in vacuum notation

Constitutive relations:

D = epsilon E
B = mu H
J = sigma E

Maxwell equations in vacuum notation:

div E = rho / epsilon_0
div B = 0
curl E = - partial B / partial t
curl B = mu_0 J + mu_0 epsilon_0 partial E / partial t

Wave speed:

c = 1 / sqrt(mu_0 epsilon_0)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/electromagnetism-and-the-unification-of-fields
