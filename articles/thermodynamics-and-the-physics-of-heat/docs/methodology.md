# Methodology Notes

## Purpose

This repository folder supports an article on thermodynamics by translating core macroscopic relations into reproducible computational workflows.

The goal is not to replace professional equation-of-state packages, calibrated thermophysical property databases, CFD codes, process-simulation software, or high-precision metrology tools. The goal is to provide transparent scaffolding for:

- ideal-gas process paths
- reversible isothermal expansion
- reversible adiabatic expansion
- constant-pressure heating
- work and heat accounting
- entropy-change calculation
- Carnot efficiency surfaces
- free-energy relation scaffolds
- response-function metadata
- process assumptions and source provenance
- reproducibility documentation

## Core Ideas

### Ideal Gas Law

PV = nRT

### First Law

dU = delta Q - delta W

### Reversible Isothermal Work

W = nRT ln(V2/V1)

### Ideal-Gas Entropy Change

Delta S = n Cv ln(T2/T1) + nR ln(V2/V1)

### Reversible Adiabatic Relation

PV^gamma = constant

### Carnot Efficiency

eta = 1 - Tc/Th

## Assumptions

The introductory workflows assume:

- ideal-gas behavior unless otherwise specified
- simple compressible systems
- constant heat capacities in introductory examples
- closed systems unless stated otherwise
- sign convention where work done by the gas is positive
- reversible paths when formulas require reversibility
- no real-gas compressibility factors unless extended separately
- no multiphase equilibrium unless added separately
- no chemical reaction unless added separately
- no production property tables

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for REFPROP-style property models, steam tables, validated heat-engine simulation, CFD, process design tools, or experimental thermometry systems.

## Computational Philosophy

The code is organized by scientific role:

- Python: process paths, work/heat/entropy summaries, Carnot surfaces, free-energy scaffolds
- R: empirical summaries, isothermal work checks, measurement comparison, visualization-ready outputs
- Julia: high-performance reversible-cycle scaffolding
- C++: performance-oriented parameter sweeps
- Fortran: classic scientific-computing thermodynamic tables
- SQL: structured metadata for systems, processes, constants, assumptions, and sources
- Rust: safe command-line utility
- C: low-level ideal-gas calculations
