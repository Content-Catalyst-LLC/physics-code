# Reproducibility Notes

## Data

Primary sample datasets:

- data/heat_residual_cases.csv
- data/decay_pinn_cases.csv
- data/inverse_diffusion_cases.csv
- data/operator_learning_cases.csv
- data/conservation_cases.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect physical equations and unit conventions
2. compute residual diagnostics for a known heat-equation solution
3. train a small PINN on an exponential decay equation
4. estimate a simple unknown diffusion parameter from synthetic data
5. generate operator-learning toy datasets
6. compute conservation diagnostics
7. store model, loss, collocation, source, and assumption metadata in SQL
8. extend examples into richer scientific machine learning workflows

## Possible Extensions

Future expansions could include:

- PINNs for heat, wave, Burgers, and Schrödinger equations
- residual-based adaptive collocation
- hard boundary-condition architectures
- neural ODE trajectory fitting
- universal differential equation closure learning
- differentiable simulator scaffolds
- DeepONet and Fourier neural operator datasets
- operator generalization tests across mesh resolutions
- Bayesian PINN examples
- ensemble uncertainty
- conservation-preserving neural architectures
- inverse parameter identifiability analysis
- VVUQ dashboards for scientific machine learning
