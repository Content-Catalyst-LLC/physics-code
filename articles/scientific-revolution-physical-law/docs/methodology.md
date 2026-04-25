# Methodology Notes

## Purpose

This repository folder supports a historically oriented physics article by turning several early modern lawlike relations into reproducible computational examples.

The goal is not to imply that Galileo, Kepler, or Newton wrote code or used modern notation in the way contemporary physicists do. The goal is to show how their law-seeking style can be reconstructed computationally.

## Historical Relations Modeled

### Galilean Free Fall

For ideal free fall from rest under constant acceleration:

s = 0.5 * g * t^2

Assumptions:

- constant gravitational acceleration near Earth
- no air resistance
- initial velocity equals zero
- vertical motion only

### Kepler-Style Orbital Scaling

For bodies orbiting the same central mass, normalized Kepler-style scaling can be written:

T = a^(3/2)

Assumptions:

- common central mass
- normalized units
- idealized orbital relation
- no multi-body perturbation

### Newtonian Gravitation

Newtonian gravitational force magnitude:

F = G * m1 * m2 / r^2

Assumptions:

- point masses or spherically symmetric masses
- classical gravitational interaction
- separation distance r is nonzero
- relativistic corrections ignored

## Computational Philosophy

The code is organized by scientific role:

- Python: transparent model construction and parameter sweeps
- R: log-log scaling and statistical model fitting
- Julia: numerical simulation of orbital dynamics
- C++: performance-oriented integration loop
- Fortran: classic scientific-computing table generation
- SQL: structured metadata, model assumptions, source notes, and simulation runs
- Rust: safe computational utility
- C: low-level calculation style useful for instrumentation analogies
