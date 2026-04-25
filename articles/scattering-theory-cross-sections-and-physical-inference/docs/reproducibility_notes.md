# Reproducibility Notes

## Data

Primary sample datasets:

- data/scattering_constants.csv
- data/angular_distribution_cases.csv
- data/resonance_cases.csv
- data/born_potential_cases.csv
- data/partial_wave_cases.csv
- data/event_rate_cases.csv
- data/detector_response_cases.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect unit and convention choices
2. integrate differential cross sections into total cross sections
3. compare numerical and analytic angular integrations
4. generate and fit synthetic resonance cross-section data
5. compute Born approximation scaffolds for simple potentials
6. summarize partial-wave contributions from phase shifts
7. translate cross section and luminosity into expected event counts
8. model simple detector smearing
9. store model, source, detector, and inference metadata in SQL
10. extend examples into richer scattering workflows

## Possible Extensions

Future expansions could include:

- hard-sphere phase-shift calculations
- Coulomb/Rutherford scattering with screening
- Yukawa potential Born approximation
- numerical radial Schrodinger equation phase shifts
- coupled-channel scattering examples
- inelastic scattering response functions
- dynamic structure factor examples
- QFT two-to-two kinematics
- Mandelstam variable utilities
- likelihood fits with nuisance parameters
- profile likelihood intervals
- Bayesian posterior inference
- detector unfolding examples
- covariance-matrix propagation
- event generator metadata
