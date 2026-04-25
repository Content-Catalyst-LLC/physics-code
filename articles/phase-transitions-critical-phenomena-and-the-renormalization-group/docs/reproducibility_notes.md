# Reproducibility Notes

## Data

Primary sample datasets:

- data/critical_phenomena_constants.csv
- data/landau_cases.csv
- data/ising_simulation_cases.csv
- data/critical_exponent_cases.csv
- data/universality_class_cases.csv
- data/rg_flow_cases.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect unit and notation conventions
2. compute Landau free-energy landscapes
3. estimate equilibrium order parameters
4. run a small 2D Ising Monte Carlo simulation
5. estimate energy, magnetization, heat capacity, and susceptibility
6. compute Binder cumulant scaffolds
7. generate finite-size scaling tables
8. compute simple correlation-function diagnostics
9. simulate RG toy flows
10. store assumptions, sources, models, exponents, and simulation runs in SQL
11. extend examples into richer critical-phenomena workflows

## Possible Extensions

Future expansions could include:

- Wolff cluster algorithm
- Swendsen-Wang cluster algorithm
- autocorrelation time estimation
- bootstrap uncertainty estimates
- critical temperature estimation from Binder crossings
- finite-size scaling data collapse
- correlation-length estimator from structure factor
- 3D Ising model simulation
- XY model and Kosterlitz-Thouless transition scaffold
- Potts model simulation
- percolation model
- mean-field self-consistency solver
- epsilon expansion notes
- RG flow visualization
- scaling collapse notebooks
