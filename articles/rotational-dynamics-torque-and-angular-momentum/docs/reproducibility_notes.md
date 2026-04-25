# Reproducibility Notes

## Data

Primary sample datasets:

- data/rotational_constants.csv
- data/rolling_body_cases.csv
- data/moment_of_inertia_shapes.csv
- data/torque_time_profile.csv
- data/gyroscope_cases.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants and units used in rotational examples
2. compare moment-of-inertia factors across common rigid bodies
3. compute rolling acceleration and final speed
4. partition kinetic energy into translational and rotational parts
5. integrate torque-driven rotation over time
6. compute angular momentum and rotational kinetic energy
7. estimate simple gyroscope-style precession
8. store assumptions, bodies, axes, and source metadata in SQL
9. extend examples into richer rotational dynamics workflows

## Possible Extensions

Future expansions could include:

- full inertia tensor examples
- Euler equations for rigid-body rotation
- torque-free precession
- gyroscope nutation
- rotational sensor data analysis
- rolling with slipping and rolling resistance
- rigid body collisions
- angular impulse experiments
- spacecraft reaction-wheel examples
- attitude dynamics with quaternions
