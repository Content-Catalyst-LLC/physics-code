# Fluid Dynamics and the Physics of Flow

This folder supports the Physics knowledge-series article **Fluid Dynamics and the Physics of Flow**.

The article examines fluids and continua, density, pressure, hydrostatics, velocity fields, the material derivative, conservation of mass, Bernoulli's equation, viscosity, Newtonian fluids, momentum balance, Navier-Stokes equations, Reynolds number, laminar flow, turbulence, boundary layers, drag, lift, vorticity, circulation, dimensional analysis, environmental flow, biological flow, engineering flow, and computational fluid dynamics.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible fluid-dynamics workflows.

## Included Materials

- Python workflows for velocity-field diagnostics, vorticity, divergence, Bernoulli calculations, advection-diffusion transport, and pipe-flow scaffolds
- R workflows for Reynolds-number classification, pipe-flow regime tables, viscosity summaries, and nondimensional analysis
- Julia flow-parameter scaffolding
- C++ Reynolds-number and Bernoulli parameter sweeps
- Fortran fluid-flow tables
- SQL metadata for fluids, flow cases, dimensionless numbers, sources, assumptions, and simulation runs
- Rust command-line utility for Reynolds number and Bernoulli calculations
- C low-level Reynolds-number table example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Density:

rho = m / V

Pressure:

p = F / A

Hydrostatic pressure:

p = p0 + rho g h

Material derivative:

D/Dt = partial/partial t + u dot grad

Continuity equation:

partial rho/partial t + div(rho u) = 0

Incompressible continuity:

div(u) = 0

Bernoulli equation:

p + 1/2 rho v^2 + rho g z = constant

Newtonian shear stress:

tau = mu du/dy

Kinematic viscosity:

nu = mu / rho

Incompressible Navier-Stokes equation:

rho(partial u/partial t + (u dot grad)u) = -grad p + mu laplacian u + f

Reynolds number:

Re = rho v L / mu = v L / nu

Vorticity:

omega = curl u

Circulation:

Gamma = integral_C u dot dl

Drag force:

F_D = 1/2 rho v^2 C_D A

Lift force:

F_L = 1/2 rho v^2 C_L A

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/fluid-dynamics-and-the-physics-of-flow
