# Reproducibility Notes

## Data

Primary sample datasets:

- data/decay_counts_sample.csv
- data/isotope_sample.csv
- data/helium4_mass_sample.csv
- data/nuclear_model_metadata.csv
- data/decay_mode_metadata.csv
- data/nuclear_data_source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect sample isotope metadata
2. fit a simple decay curve
3. estimate a decay constant and half-life
4. compute a schematic helium-4 binding energy
5. compare binding energy per nucleon
6. run a semi-empirical mass-formula scaffold
7. store isotope, decay, model, and source metadata in SQL
8. extend examples into richer nuclear-data workflows

## Possible Extensions

Future expansions could include:

- evaluated mass-table ingestion
- uncertainty propagation for binding-energy calculations
- decay-chain daughter buildup under safe educational constraints
- activity-unit conversion
- isotope metadata dashboards
- gamma-line metadata tables
- semi-empirical mass-formula residual analysis
- chart-of-nuclides visualization
- cross-section metadata without operational reactor optimization
