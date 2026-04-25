# Reproducibility Notes

## Data

Primary sample datasets:

- data/box_parameters.csv
- data/quantum_constants.csv
- data/sample_measurements.csv
- data/operator_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect the physical constants used in calculations
2. compute particle-in-a-box eigenstates and energies
3. verify numerical normalization of probability densities
4. compute expectation values and uncertainty estimates
5. simulate measurement samples from a probability density
6. compare analytic and finite-difference eigenvalues
7. store run metadata, operator definitions, and source notes in SQL
8. extend the examples into richer quantum-mechanics workflows

## Possible Extensions

Future expansions could include:

- finite square well
- tunneling through a rectangular barrier
- harmonic oscillator eigenstates
- Gaussian wave-packet time evolution
- split-step Fourier time propagation
- two-state spin systems
- uncertainty in momentum space
- operator commutator matrices
- measurement histograms from simulated detectors
- quantum-information two-state examples
