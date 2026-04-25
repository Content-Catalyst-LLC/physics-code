# Reproducibility Notes

## Data

Primary sample datasets:

- data/constants.csv
- data/markov_cycle_cases.csv
- data/langevin_cases.csv
- data/fokker_planck_cases.csv
- data/green_kubo_cases.csv
- data/fluctuation_theorem_cases.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect unit and convention choices
2. compute steady probability currents in a Markov cycle
3. compute entropy production from transition rates
4. simulate overdamped Langevin trajectories
5. compare stochastic trajectories with equilibrium variance expectations
6. generate simple Fokker-Planck relaxation scaffolds
7. estimate diffusion from velocity or displacement correlations
8. test a simple fluctuation-theorem ratio
9. store model, source, and assumption metadata in SQL
10. extend examples into richer nonequilibrium workflows

## Possible Extensions

Future expansions could include:

- kinetic Monte Carlo simulation
- Gillespie algorithm for reaction networks
- multidimensional Langevin dynamics
- underdamped Langevin dynamics
- nonconservative force fields and steady currents
- Fokker-Planck finite-difference solvers
- Boltzmann equation relaxation-time approximation
- lattice Boltzmann scaffolds
- Green-Kubo viscosity estimates
- Jarzynski equality work-pulling simulations
- Crooks forward/reverse work-distribution checks
- stochastic heat-engine examples
- active Brownian particle simulation
- chemical reaction network entropy production
- fluctuation-dissipation violation diagnostics
