# Methodology Notes

## Purpose

This repository folder supports an article on physics, technology, and the modern world by turning core physical technology relations into reproducible computational examples.

The goal is to show how simple physical relations become infrastructure-level constraints when embedded in timing systems, power systems, semiconductor devices, sensors, and thermal processes.

## Core Relations

### Timing and Position

d = c * t

delta_d = c * delta_t

where:

- d is distance in meters
- c is the speed of light in meters per second
- t is time in seconds
- delta_t is timing uncertainty in seconds
- delta_d is distance uncertainty in meters

### Power

P = E / t

where:

- P is power in watts
- E is energy in joules
- t is time in seconds

### Electrical Power

P = I * V

where:

- I is current in amperes
- V is voltage in volts

### RC Delay Approximation

tau = R * C

where:

- tau is characteristic delay in seconds
- R is resistance in ohms
- C is capacitance in farads

### One-Dimensional Heat Diffusion

dT/dt = alpha * d2T/dx2

where:

- T is temperature
- t is time
- alpha is thermal diffusivity
- x is spatial position

## Computational Philosophy

The code is organized by scientific role:

- Python: transparent modeling, parameter sweeps, and tabular outputs
- R: measurement uncertainty and infrastructure error summaries
- Julia: numerical simulation of diffusion-like behavior
- C++: performance-oriented parameter sweep loops
- Fortran: classic scientific-computing thermal simulation scaffold
- SQL: structured metadata for technology domains and simulation runs
- Rust: safe command-line utility
- C: low-level instrumentation-style conversion example
