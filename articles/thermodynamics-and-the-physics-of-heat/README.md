# Thermodynamics and the Physics of Heat

This folder supports the Physics knowledge-series article **Thermodynamics and the Physics of Heat**.

The article examines heat, temperature, thermal energy, state variables, equilibrium, the laws of thermodynamics, entropy, irreversibility, enthalpy, free energies, response functions, equations of state, reversible cycles, Carnot efficiency, and the transition from macroscopic thermodynamics to statistical physics.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible thermodynamics workflows.

## Included Materials

- Python workflows for ideal-gas process paths, reversible and irreversible summaries, Carnot-cycle efficiency, and free-energy surfaces
- R workflows for isothermal expansion, entropy accounting, thermal measurement summaries, and process comparison
- Julia reversible-cycle and thermodynamic-state scaffolding
- C++ heat-engine and process-parameter sweeps
- Fortran ideal-gas and heat-capacity table generation
- SQL metadata for thermodynamic systems, processes, constants, source notes, model assumptions, and simulation runs
- Rust command-line utility for ideal-gas process summaries
- C low-level ideal-gas work and entropy example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Ideal gas law:

PV = nRT

First law:

dU = delta Q - delta W

Reversible pressure-volume work:

W = integral P dV

Reversible isothermal ideal-gas work:

W = nRT ln(V2/V1)

Ideal-gas entropy change:

Delta S = n Cv ln(T2/T1) + n R ln(V2/V1)

Internal energy change for ideal gas:

Delta U = n Cv Delta T

Enthalpy change for ideal gas:

Delta H = n Cp Delta T

Carnot efficiency:

eta = 1 - Tc/Th

Helmholtz free energy:

F = U - TS

Gibbs free energy:

G = H - TS

Heat capacities:

Cv = (partial U / partial T)_V
Cp = (partial H / partial T)_P

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/thermodynamics-and-the-physics-of-heat
