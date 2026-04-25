# Reproducibility Notes

## Data

Primary sample datasets:

- data/experimental_constants.csv
- data/calibration_points.csv
- data/uncertainty_budget_cases.csv
- data/noise_signal_cases.csv
- data/instrument_metadata.csv
- data/measurement_run_metadata.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants and units
2. fit a calibration curve
3. evaluate calibration residuals
4. simulate noisy measurement signals
5. estimate signal-to-noise ratio
6. propagate uncertainty analytically
7. propagate uncertainty by Monte Carlo sampling
8. perform a simple Bayesian measurement update
9. store instrument, calibration, measurement, uncertainty, and source metadata in SQL
10. extend examples into richer experimental-physics workflows

## Possible Extensions

Future expansions could include:

- weighted least-squares calibration
- errors-in-variables calibration
- nonlinear calibration curves
- uncertainty covariance matrices
- Monte Carlo propagation using non-Gaussian inputs
- Allan deviation for oscillator stability
- lock-in detection simulation
- matched filtering
- frequency-domain noise models
- instrument drift correction
- blind analysis metadata
- calibration certificate metadata parser
- environmental correction models
- hierarchical Bayesian calibration
- laboratory provenance dashboards
