# Reproducibility Notes

## Data

Primary sample datasets:

- data/electromagnetic_constants.csv
- data/point_charge_measurements.csv
- data/material_properties.csv
- data/maxwell_relations.csv
- data/source_metadata.csv
- data/model_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect the constants used in electromagnetism calculations
2. compute point-charge field and electric potential
3. compare theoretical and measured field values
4. compute magnetic-field scaling around a straight wire
5. compute potential grids and recover fields from gradients
6. model dipole-style superposition
7. solve a simple finite-difference Laplace boundary scaffold
8. store constants, models, and source provenance in SQL
9. extend the examples into richer electromagnetism workflows

## Possible Extensions

Future expansions could include:

- finite-difference Poisson equation solver
- conductor boundary-value examples
- dielectric interface conditions
- capacitance matrix estimation
- Biot-Savart line-current integration
- solenoid and loop-field approximations
- induction coil voltage tables
- electromagnetic-wave time-domain examples
- transmission-line scaffolds
- material dispersion metadata
- antenna radiation pattern approximations
