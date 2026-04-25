# Reproducibility Notes

## Data

Primary sample datasets:

- data/constants.csv
- data/gl_parameter_cases.csv
- data/josephson_cases.csv
- data/flux_loop_cases.csv
- data/vortex_cases.csv
- data/bcs_gap_cases.csv
- data/material_examples.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants and unit conventions
2. compute Ginzburg-Landau free-energy curves
3. identify equilibrium order-parameter amplitude below Tc
4. simulate simplified Josephson phase dynamics
5. compute flux quantum values and loop flux states
6. generate superfluid vortex phase maps
7. compute simplified BCS gap-temperature tables
8. store model, source, and assumption metadata in SQL
9. extend examples into richer superconductivity and superfluidity workflows

## Possible Extensions

Future expansions could include:

- spatial Ginzburg-Landau equation solvers
- vortex-core order-parameter profiles
- Abrikosov lattice visualizations
- time-dependent Ginzburg-Landau scaffolds
- RCSJ Josephson junction model
- SQUID interference curves
- Gross-Pitaevskii equation examples
- vortex nucleation in rotating condensates
- BCS density of states
- Bogoliubov quasiparticle spectra
- unconventional gap symmetry examples
- superconducting qubit circuit Hamiltonians
