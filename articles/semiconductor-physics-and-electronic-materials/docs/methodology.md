# Methodology Notes

## Purpose

This repository folder supports an article on semiconductor physics and electronic materials by translating band-gap physics, carrier statistics, doping, conductivity, p-n junction electrostatics, diode curves, MOS capacitance, mobility, and semiconductor metadata into reproducible computational workflows.

The goal is not to replace TCAD platforms, density-functional theory packages, process simulators, circuit simulators, foundry models, or laboratory metrology pipelines. The goal is to provide transparent scaffolding for:

- intrinsic carrier concentration
- carrier concentration approximations
- conductivity and resistivity
- thermal voltage
- p-n junction built-in potential
- depletion width
- ideal diode current-voltage behavior
- MOS oxide capacitance
- mobility sensitivity
- semiconductor material parameters
- source provenance
- reproducibility documentation

## Core Ideas

### Carrier Statistics

ni = sqrt(Nc Nv) exp[-Eg/(2 kB T)]

np = ni^2

### Conductivity

sigma = q(n mu_n + p mu_p)

rho = 1/sigma

### Transport

Jn = q n mu_n E + q Dn grad(n)

Jp = q p mu_p E - q Dp grad(p)

D = mu kB T/q

### Junctions

Vbi = (kB T/q) ln(NA ND / ni^2)

W = sqrt[(2 epsilon_s/q)((NA+ND)/(NA ND))(Vbi - V)]

### Diodes

I = Is[exp(qV/(n kB T)) - 1]

### MOS

Cox = epsilon_ox/t_ox

## Assumptions

The introductory workflows assume:

- nondegenerate carrier statistics
- full dopant ionization where explicitly stated
- simple majority-carrier conductivity approximations
- ideal abrupt p-n junctions
- depletion approximation
- ideal diode equation unless otherwise documented
- simplified MOS oxide capacitance
- fixed material parameters unless swept
- no full TCAD drift-diffusion-Poisson solver in introductory scripts
- no quantum confinement in introductory MOS examples
- no fabrication process simulation
- no foundry-specific compact model

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for TCAD, SPICE model extraction, semiconductor process simulation, density-functional theory, high-field transport simulation, or validated device engineering.

## Computational Philosophy

The code is organized by scientific role:

- Python: device curves, carrier concentration, p-n junction electrostatics, MOS capacitance
- R: parameter sweeps, conductivity and resistivity summaries
- Julia: compact semiconductor calculations
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing junction tables
- SQL: structured metadata for materials, devices, constants, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
