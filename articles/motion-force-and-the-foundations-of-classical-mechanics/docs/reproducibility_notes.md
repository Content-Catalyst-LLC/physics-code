# Reproducibility Notes

## Data

Primary sample datasets:

- data/mechanics_constants.csv
- data/projectile_cases.csv
- data/trajectory_measurements.csv
- data/force_time_measurements.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants used in classical-mechanics calculations
2. compute ideal projectile trajectories
3. compare ideal and drag-including projectile models
4. fit a quadratic trajectory to measurement-style data
5. summarize residuals between measurement and model
6. compute impulse from force-time data
7. apply Newton's second law across parameter sweeps
8. store systems, assumptions, and source metadata in SQL
9. extend the examples into richer mechanics workflows

## Possible Extensions

Future expansions could include:

- inclined-plane force decomposition
- pendulum motion
- rolling motion
- circular motion and centripetal acceleration
- spring force and oscillation
- two-body gravitational motion
- collision and momentum conservation
- rocket equation scaffolds
- rigid-body rotation
- numerical energy drift diagnostics
- uncertainty propagation from measured position and time
