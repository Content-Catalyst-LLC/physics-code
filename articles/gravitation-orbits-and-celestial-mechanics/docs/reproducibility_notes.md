# Reproducibility Notes

## Data

Primary sample datasets:

- data/gravitational_constants.csv
- data/central_bodies.csv
- data/orbital_cases.csv
- data/hohmann_transfer_cases.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants and gravitational parameters used in examples
2. compute circular orbit speed and escape speed
3. compute orbital period scaling
4. integrate two-body motion numerically
5. track energy and angular momentum diagnostics
6. compute simple Hohmann transfer delta-v estimates
7. classify ideal orbital energy as bound, parabolic, or hyperbolic
8. store assumptions, bodies, orbits, and sources in SQL
9. extend examples into richer celestial-mechanics workflows

## Possible Extensions

Future expansions could include:

- elliptical orbital elements from state vectors
- Kepler equation solver
- anomaly conversions
- J2 oblateness perturbation
- lunar perturbation examples
- three-body restricted problem
- Lagrange points
- resonant orbit examples
- gravity assist scaffolds
- atmospheric drag for low Earth orbit
- relativistic perihelion correction
- SPICE kernel metadata interfaces
