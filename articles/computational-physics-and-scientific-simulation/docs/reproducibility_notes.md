# Reproducibility Notes

## Data

Primary sample datasets:

- data/simulation_parameters.csv
- data/projectile_uncertainty_cases.csv
- data/diffusion_grid_cases.csv
- data/numerical_methods_catalog.csv
- data/vvuq_checklist.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect simulation parameters and units
2. run a finite-difference diffusion model
3. check the explicit diffusion stability number
4. integrate a simple ODE and monitor energy
5. run Monte Carlo uncertainty propagation
6. compare convergence across grid sizes
7. store assumptions, solver settings, variables, and sources in SQL
8. extend examples into richer computational-physics workflows

## Possible Extensions

Future expansions could include:

- adaptive time stepping
- implicit diffusion methods
- Crank-Nicolson method
- 2D heat equation
- wave equation solver
- Poisson solver
- finite volume conservation example
- finite element weak-form example
- Monte Carlo integration
- Markov chain Monte Carlo
- molecular dynamics velocity Verlet
- N-body gravitational simulation
- GPU acceleration scaffold
- MPI-style domain decomposition notes
- formal verification and validation checklist
