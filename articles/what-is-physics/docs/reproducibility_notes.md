# Reproducibility Notes

## Data

The primary sample dataset is:

- data/pendulum_measurements.csv

It contains repeated timing measurements for pendulums of different lengths.

## Reproducibility Goals

This folder is designed to make the article computationally extendable. A reader should be able to:

1. inspect measured data
2. compute ideal-model predictions
3. compare measured and predicted periods
4. calculate residuals and percent error
5. estimate measurement uncertainty
6. simulate oscillator dynamics numerically
7. store experiment and simulation metadata
8. extend the examples into more advanced numerical workflows

## Possible Extensions

Future expansions could include:

- nonlinear pendulum dynamics
- large-angle correction
- damping and drag
- Bayesian uncertainty modeling
- sensor-derived timing data
- automated experiment logging
- comparison of Euler, symplectic Euler, Verlet, and Runge-Kutta methods
- notebook-based instructional workflows
- parameter-sweep dashboards
