# Reproducibility Notes

## Data

Primary sample datasets:

- data/thermodynamic_constants.csv
- data/ideal_gas_process_cases.csv
- data/thermal_measurements.csv
- data/thermodynamic_process_metadata.csv
- data/source_metadata.csv
- data/model_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants used in thermodynamic calculations
2. compute ideal-gas state variables
3. compute reversible isothermal work and entropy change
4. compare analytic and numerical work integrals
5. compare isothermal, adiabatic, and constant-pressure paths
6. compute Carnot efficiencies across reservoir temperatures
7. explore simple free-energy relation scaffolds
8. store systems, processes, constants, and assumptions in SQL
9. extend the examples into richer thermodynamics workflows

## Possible Extensions

Future expansions could include:

- van der Waals gas comparison
- real-gas compressibility factor scaffolds
- heat-capacity polynomial integration
- steam-table metadata
- refrigeration and heat-pump cycles
- Brayton, Otto, Diesel, and Rankine cycle scaffolds
- entropy generation accounting
- exergy analysis
- calorimetry uncertainty propagation
- phase-equilibrium free-energy examples
- Gibbs energy minimization scaffolds
