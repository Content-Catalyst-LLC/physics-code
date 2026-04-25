# Relativity and the Reconstruction of Space and Time

This folder supports the Physics knowledge-series article **Relativity and the Reconstruction of Space and Time**.

The article examines special relativity, Lorentz transformation, simultaneity, proper time, spacetime interval, time dilation, length contraction, velocity composition, four-vectors, relativistic energy and momentum, rapidity, Doppler shift, measurement standards, and practical engineering applications.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible special-relativity workflows.

## Included Materials

- Python workflows for Lorentz transformations, spacetime interval invariance, velocity composition, rapidity boosts, Doppler shifts, and event metadata
- R workflows for Lorentz-factor summaries, relativistic energy scaling, and low-speed approximation comparison
- Julia rapidity and boost-composition scaffold
- C++ parameter sweeps for Lorentz factor and velocity composition
- Fortran Lorentz-factor table generation
- SQL metadata for frames, events, transformations, constants, source notes, model assumptions, and simulation runs
- Rust command-line utility for Lorentz-factor and velocity-composition calculations
- C low-level Lorentz-factor table example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Lorentz factor:

gamma = 1 / sqrt(1 - beta^2)

Dimensionless velocity:

beta = v / c

Lorentz transformation for motion along x:

x_prime = gamma (x - v t)

t_prime = gamma (t - v x / c^2)

Spacetime interval:

Delta s^2 = c^2 Delta t^2 - Delta x^2 - Delta y^2 - Delta z^2

Time dilation:

Delta t = gamma Delta tau

Length contraction:

L = L0 / gamma

Velocity composition:

u_prime = (u - v) / (1 - uv/c^2)

Energy-momentum relation:

E^2 = (pc)^2 + (mc^2)^2

Rapidity:

beta = tanh eta
gamma = cosh eta
gamma beta = sinh eta

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/relativity-and-the-reconstruction-of-space-and-time
