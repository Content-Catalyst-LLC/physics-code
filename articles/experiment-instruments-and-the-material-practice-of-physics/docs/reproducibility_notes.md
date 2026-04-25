# Reproducibility Notes

## Data

Primary sample datasets:

- data/pendulum_measurements.csv
- data/calibration_data.csv
- data/instrument_metadata.csv
- data/measurement_chain_metadata.csv
- data/detector_signal_samples.csv

## Reproducibility Goals

A reader should be able to:

1. inspect raw repeated measurements with units and uncertainty fields
2. compute a mean period from repeated pendulum timings
3. infer gravitational acceleration from a measurement model
4. propagate uncertainty by first-order approximation and Monte Carlo simulation
5. fit a calibration curve and inspect residuals
6. simulate a detector-style signal chain
7. store experimental metadata in SQL
8. extend examples into richer experimental-physics workflows

## Possible Extensions

Future expansions could include:

- covariance-aware uncertainty propagation
- GUM-style uncertainty reports
- Bayesian calibration models
- detector efficiency correction
- Poisson counting statistics
- lock-in amplifier signal recovery examples
- spectral line calibration
- signal filtering and threshold optimization
- provenance tracking for raw and processed datasets
