# Methodology Notes

## Purpose

This repository folder supports an article on physics-informed machine learning and scientific computing by translating PINN residuals, neural ODE concepts, universal differential equations, operator-learning scaffolds, inverse parameter estimation, conservation diagnostics, and scientific ML provenance into reproducible computational workflows.

The goal is not to replace production PINN libraries, neural operator frameworks, differentiable simulation systems, finite element solvers, computational fluid dynamics codes, climate models, quantum chemistry packages, or formal uncertainty quantification platforms. The goal is to provide transparent scaffolding for:

- physics-informed residual diagnostics
- small PINN training examples
- inverse parameter estimation
- neural ODE and universal differential equation concepts
- operator-learning dataset generation
- conservation-law diagnostics
- scaling and nondimensionalization documentation
- uncertainty and identifiability notes
- source provenance
- reproducibility documentation

## Assumptions

The introductory workflows assume:

- small teaching-scale systems
- simple ODE and heat-equation examples
- dimensionless variables unless specified
- automatic differentiation through small neural networks
- residual diagnostics on known analytic solutions
- no production-scale PDE solver
- no production neural operator training
- no large GPU training requirement

## Computational Philosophy

The code is organized by scientific role:

- Python: PINNs, automatic differentiation, inverse examples, neural/scientific ML workflows
- R: residual diagnostics and audit summaries
- Julia: SciML-style conceptual scaffolding
- C++: fast residual and parameter sweeps
- Fortran: finite-difference baseline tables
- SQL: structured metadata for sources, losses, models, parameters, data, and runs
- Rust: safe command-line utility
- C: low-level residual calculations
