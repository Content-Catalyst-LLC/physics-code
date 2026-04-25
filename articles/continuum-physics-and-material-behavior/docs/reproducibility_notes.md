# Reproducibility Notes

## Data

Primary sample datasets:

- data/material_properties.csv
- data/stress_strain_test.csv
- data/stress_tensor_cases.csv
- data/beam_cases.csv
- data/viscoelastic_cases.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect material properties used in examples
2. estimate Young's modulus from stress-strain data
3. compute approximate strain energy density
4. compute principal stresses from stress tensors
5. compute hydrostatic and deviatoric stress
6. compute von Mises equivalent stress
7. evaluate simple yield diagnostics
8. compute ideal beam deflection estimates
9. simulate simple viscoelastic creep or relaxation scaffolds
10. store assumptions, material tests, tensors, and sources in SQL
11. extend examples into richer computational material-behavior workflows

## Possible Extensions

Future expansions could include:

- finite element method assembly for 1D bars
- plane stress and plane strain examples
- Mohr circle visualization
- anisotropic stiffness matrices
- composite laminate theory scaffold
- nonlinear hyperelasticity examples
- J2 plasticity return mapping
- fracture toughness calculations
- Paris-law fatigue crack growth
- creep and stress relaxation fitting
- digital image correlation metadata
- uncertainty propagation in material tests
