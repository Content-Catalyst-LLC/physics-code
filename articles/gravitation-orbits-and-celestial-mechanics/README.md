# Gravitation, Orbits, and Celestial Mechanics

This folder supports the Physics knowledge-series article **Gravitation, Orbits, and Celestial Mechanics**.

The article examines Newtonian gravitation, Kepler's laws, central-force motion, the two-body problem, orbital energy, angular momentum, circular orbits, escape speed, the vis-viva equation, orbital elements, perturbations, tides, resonances, the many-body problem, and basic spaceflight-transfer reasoning.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible celestial-mechanics workflows.

## Included Materials

- Python workflows for two-body integration, orbital energy diagnostics, circular orbit tables, escape speed, and Hohmann transfer scaffolds
- R workflows for circular orbit scaling, orbital periods, escape speed, and period-law summaries
- Julia orbit and transfer scaffolding
- C++ circular orbit and Hohmann transfer parameter sweeps
- Fortran orbital period and velocity tables
- SQL metadata for celestial bodies, constants, orbital cases, source notes, assumptions, and simulation runs
- Rust command-line utility for circular orbit and escape speed calculations
- C low-level orbital speed table example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Newtonian gravitation:

F = G m1 m2 / r^2

Gravitational potential energy:

U = -G M m / r

Standard gravitational parameter:

mu = G M

Circular orbital speed:

v_circ = sqrt(mu / r)

Escape speed:

v_esc = sqrt(2 mu / r)

Orbital period for circular orbit:

T = 2 pi sqrt(r^3 / mu)

Specific orbital energy:

epsilon = v^2 / 2 - mu / r

Elliptic-orbit energy:

epsilon = -mu / (2a)

Vis-viva equation:

v^2 = mu(2/r - 1/a)

Specific angular momentum:

h = r x v

Areal velocity:

dA/dt = h/2

Kepler's third law:

T^2 = 4 pi^2 a^3 / mu

Hohmann transfer semimajor axis:

a_t = (r1 + r2)/2

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/gravitation-orbits-and-celestial-mechanics
