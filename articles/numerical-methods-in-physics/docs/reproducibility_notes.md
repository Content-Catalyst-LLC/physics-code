# Reproducibility Notes

## Data

Primary sample datasets:

- data/derivative_convergence_cases.csv
- data/heat_equation_cases.csv
- data/ode_cases.csv
- data/poisson_cases.csv
- data/monte_carlo_cases.csv
- data/eigenvalue_cases.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect unit and convention choices
2. compute finite difference derivative errors
3. estimate observed convergence order
4. run stable and unstable heat-equation cases
5. compare ODE integrator errors
6. solve a sparse one-dimensional Poisson problem
7. estimate pi by Monte Carlo and observe sampling scaling
8. approximate energy eigenvalues for a simple quantum well
9. store method, solver, grid, source, and assumption metadata in SQL
10. extend examples into richer numerical physics workflows

## Possible Extensions

Future expansions could include:

- finite volume conservation checks
- finite element weak-form examples
- spectral differentiation
- adaptive Runge-Kutta integrators
- stiff ODE examples
- symplectic integrators for Hamiltonian systems
- multigrid Poisson solvers
- Krylov subspace methods
- preconditioner comparisons
- finite-difference Schrödinger solvers
- Monte Carlo integration with variance reduction
- Markov chain Monte Carlo examples
- verification with manufactured solutions
- validation against experimental data
- uncertainty propagation and sensitivity analysis
