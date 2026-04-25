# Reproducibility Notes

## Data

Primary sample datasets:

- data/biophysical_constants.csv
- data/diffusion_cases.csv
- data/binding_cases.csv
- data/ion_gradient_cases.csv
- data/enzyme_kinetic_cases.csv
- data/motor_step_cases.csv
- data/biomechanics_cases.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants and units
2. compute diffusion time scales
3. simulate Brownian motion
4. compute mean squared displacement
5. estimate Stokes-Einstein diffusion
6. compute binding occupancy
7. compute Nernst equilibrium potentials
8. compute Michaelis-Menten reaction rates
9. simulate simple molecular motor stepping
10. compute basic biomechanics quantities
11. store assumptions, parameters, sources, and workflows in SQL
12. extend examples into richer biophysics workflows

## Possible Extensions

Future expansions could include:

- reaction-diffusion simulation
- membrane cable equation
- Hodgkin-Huxley model
- Goldman-Hodgkin-Katz voltage equation
- stochastic ion-channel gating
- worm-like chain polymer model
- optical tweezer force-extension curves
- FRET efficiency models
- protein folding two-state model
- ligand competition model
- cooperative Hill binding
- molecular motor force-velocity relation
- soft-matter viscoelastic model
- cytoskeletal network mechanics
- Poiseuille flow networks
- cell migration stochastic model
