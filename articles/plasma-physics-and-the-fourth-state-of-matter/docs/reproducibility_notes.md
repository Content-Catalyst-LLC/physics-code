# Reproducibility Notes

## Data

Primary sample datasets:

- data/plasma_constants.csv
- data/plasma_regime_cases.csv
- data/magnetic_field_cases.csv
- data/particle_species.csv
- data/diagnostic_catalog.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants and units
2. compute Debye length
3. compute Debye sphere particle number
4. compute electron plasma frequency
5. compute cyclotron frequency
6. compute gyroradius
7. compute plasma pressure and magnetic pressure
8. compute plasma beta
9. compute Alfvén speed
10. integrate single-particle Lorentz-force motion
11. store assumptions, regimes, diagnostics, and sources in SQL
12. extend examples into richer plasma-physics workflows

## Possible Extensions

Future expansions could include:

- collision frequency estimates
- mean free path calculations
- sheath thickness estimates
- Langmuir probe I-V curve model
- two-stream instability toy model
- drift wave toy model
- Alfvén wave dispersion
- MHD shock relations
- magnetic mirror particle motion
- E cross B drift trajectories
- particle-in-cell toy model
- Vlasov-Poisson solver scaffold
- MHD finite-volume scaffold
- fusion triple-product calculator
- tokamak safety-factor metadata
- low-temperature plasma chemistry metadata
