# Reproducibility Notes

## Data

Primary sample datasets:

- data/climate_constants.csv
- data/albedo_feedback_cases.csv
- data/co2_scenarios.csv
- data/energy_balance_parameters.csv
- data/two_layer_parameters.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect radiation constants and units
2. compute absorbed shortwave radiation
3. compute effective emission temperature
4. compute approximate CO2 radiative forcing
5. estimate equilibrium warming for feedback assumptions
6. integrate a one-layer energy-balance model
7. integrate a two-layer ocean heat uptake model
8. run albedo and feedback sensitivity sweeps
9. propagate uncertainty through a reduced model
10. store assumptions, relations, parameters, scenarios, and sources in SQL
11. extend examples into richer climate-physics workflows

## Possible Extensions

Future expansions could include:

- seasonal insolation calculations
- latitudinal energy-balance model
- diffusive meridional heat transport
- nonlinear ice-albedo feedback
- volcanic aerosol forcing scenario
- solar forcing scenario
- equilibrium climate sensitivity Monte Carlo
- transient climate response comparison
- energy imbalance observation table
- ocean heat content conversion
- two-box calibration to historical data
- carbon cycle impulse response
- line-by-line radiative transfer notes
