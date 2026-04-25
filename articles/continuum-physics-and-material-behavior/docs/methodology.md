# Methodology Notes

## Purpose

This repository folder supports an article on continuum physics and material behavior by translating core deformation, stress, elasticity, plasticity, and viscoelasticity concepts into reproducible computational workflows.

The goal is not to replace professional finite element packages, materials testing systems, fracture-analysis software, or high-fidelity constitutive modeling platforms. The goal is to provide transparent scaffolding for:

- stress-strain analysis
- Young's modulus estimation
- elastic energy density
- stress tensor diagnostics
- principal stresses
- hydrostatic and deviatoric stress
- von Mises yield diagnostics
- beam-deflection calculations
- simple viscoelastic response
- constitutive-model metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Stress and Strain

epsilon = Delta L / L0

sigma = F / A0

sigma = E epsilon

### Tensor Strain

epsilon_ij = 1/2(partial u_i/partial x_j + partial u_j/partial x_i)

### Stress and Traction

t(n) = sigma n

### Balance Laws

div(sigma) + b = 0

div(sigma) + b = rho a

### Linear Elasticity

sigma_ij = C_ijkl epsilon_kl

For isotropic materials:

sigma_ij = lambda epsilon_kk delta_ij + 2 mu epsilon_ij

### Energy

w = 1/2 sigma_ij epsilon_ij

### Yield

sigma_vM = sqrt(3/2 s_ij s_ij)

## Assumptions

The introductory workflows assume:

- continuum approximation
- SI units
- small strain unless otherwise stated
- linear elasticity for modulus estimation
- symmetric Cauchy stress tensors
- isotropic elasticity for simple property conversions
- simplified beam theory for beam-deflection examples
- simple spring-dashpot viscoelastic models
- no production finite element meshing
- no validated fracture or fatigue life prediction
- no high-fidelity nonlinear constitutive calibration

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for Abaqus, ANSYS Mechanical, COMSOL, CalculiX, FEniCS, MOOSE, FEBio, LS-DYNA, or laboratory-certified material testing and fracture-analysis systems.

## Computational Philosophy

The code is organized by scientific role:

- Python: tensor diagnostics, eigenvalues, von Mises stress, beam and viscoelastic scaffolds
- R: material-test tables, modulus estimation, energy summaries, property summaries
- Julia: compact material-response calculations
- C++: performance-oriented yield and elasticity parameter sweeps
- Fortran: classic scientific-computing stress-strain tables
- SQL: structured metadata for materials, tests, tensors, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
