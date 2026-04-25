# Reproducibility Notes

## Data

Primary sample datasets:

- data/cosmology_parameters.csv
- data/redshift_grid.csv
- data/survey_metadata.csv
- data/simulation_metadata.csv
- data/bao_reference_scales.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect cosmological parameter assumptions
2. compute expansion history tables
3. compute basic distance-redshift relations
4. approximate linear growth factors
5. generate toy matter power-spectrum tables
6. inspect BAO standard-ruler relations
7. summarize survey observables and tracer types
8. summarize simulation metadata
9. store cosmology, survey, simulation, source, and assumption metadata in SQL
10. extend examples into richer cosmology workflows

## Possible Extensions

Future expansions could include:

- radiation and curvature terms in distance calculations
- CPL dark-energy parameterization
- sound horizon calculations
- exact growth ODE integration
- CLASS or CAMB interfaces
- nonlinear power-spectrum comparison
- halo mass function scaffolds
- Press-Schechter and Sheth-Tormen models
- redshift-space distortion models
- weak-lensing kernel calculations
- cosmic shear power spectra
- MCMC parameter inference examples
- survey covariance scaffolds
- mock catalog generation
- N-body initial condition notes
- emulator metadata
