# Reproducibility Notes

## Data

Primary sample datasets:

- data/fluid_properties.csv
- data/pipe_flow_cases.csv
- data/bernoulli_cases.csv
- data/dimensionless_numbers.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect fluid properties used in examples
2. compute Reynolds number across flow cases
3. classify simple pipe-flow regimes
4. compute kinematic viscosity from dynamic viscosity and density
5. compute Bernoulli pressure changes
6. build simple incompressible velocity fields
7. compute divergence and vorticity
8. run a finite-difference advection-diffusion scaffold
9. store assumptions, flow cases, and sources in SQL
10. extend examples into richer fluid-dynamics workflows

## Possible Extensions

Future expansions could include:

- Poiseuille flow profiles
- pipe-friction and Moody chart approximations
- boundary-layer scaling
- vortex-shedding Strouhal number examples
- finite-volume advection examples
- lid-driven cavity flow
- incompressible projection method
- turbulence energy spectrum scaffold
- shallow-water equations
- atmospheric or oceanic flow examples
- groundwater/porous-media flow
- non-Newtonian rheology examples
