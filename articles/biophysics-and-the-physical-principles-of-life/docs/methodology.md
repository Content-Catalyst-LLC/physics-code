# Methodology Notes

## Purpose

This repository folder supports an article on biophysics by translating diffusion, Brownian motion, binding occupancy, Nernst potentials, membrane capacitance, Michaelis-Menten kinetics, stochastic molecular motor stepping, and biomechanics into reproducible computational workflows.

The goal is not to replace molecular dynamics packages, electrophysiology software, structural biology pipelines, computational chemistry suites, finite-element biomechanics platforms, or systems biology simulators. The goal is to provide transparent scaffolding for:

- diffusion time-scale estimates
- Brownian motion and mean squared displacement
- Stokes-Einstein diffusion estimates
- ligand binding occupancy
- Nernst equilibrium potentials
- membrane capacitance
- Michaelis-Menten kinetics
- stochastic molecular motor stepping
- simple biomechanics relations
- source provenance
- reproducibility documentation

## Core Ideas

### Thermal Probability

P_i = exp(-E_i/(kB T))/Z

### Diffusion

<r^2> = 2 d D t

where d is spatial dimension.

### Stokes-Einstein

D = kB T/(6 pi eta r)

### Binding

theta = [L]/(KD + [L])

### Electrochemical Gradients

E = (RT/zF) ln(c_out/c_in)

### Enzyme Kinetics

v = Vmax [S]/(KM + [S])

### Mechanics

F = kx

sigma = F/A

epsilon = DeltaL/L

## Assumptions

The introductory workflows assume:

- simple diffusion in homogeneous media
- Brownian motion without drift or boundaries
- ideal binding equilibrium with one binding site class
- Nernst equilibrium for a single ion species
- no full Goldman-Hodgkin-Katz membrane model in introductory scripts
- Michaelis-Menten kinetics under standard simplifying assumptions
- simple stochastic stepping for molecular motors
- no full molecular dynamics simulation
- no spatial reaction-diffusion solver in introductory scripts
- no tissue-scale finite-element model

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for GROMACS, NAMD, AMBER, CHARMM, OpenMM, NEURON, COPASI, COMSOL, finite-element biomechanics software, cryo-EM processing suites, or experimental analysis pipelines.

## Computational Philosophy

The code is organized by scientific role:

- Python: stochastic simulation, Brownian motion, binding, Nernst, kinetics
- R: parameter sweeps, sensitivity tables, reproducible summaries
- Julia: compact biophysical calculations
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing tables
- SQL: structured metadata for constants, biological scales, models, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
