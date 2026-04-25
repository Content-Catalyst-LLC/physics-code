# Climate Physics and Planetary Energy Balance

This folder supports the Physics knowledge-series article **Climate Physics and Planetary Energy Balance**.

The article examines planetary radiation balance, solar irradiance, albedo, absorbed shortwave radiation, outgoing longwave radiation, effective emission temperature, the Stefan-Boltzmann law, greenhouse physics, radiative transfer, radiative forcing, climate feedbacks, ocean heat uptake, cryosphere feedbacks, orbital forcing, reduced energy-balance models, planetary habitability, and computational climate modeling.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible climate-physics workflows.

## Included Materials

- Python workflows for one-layer and two-layer energy-balance models, radiative forcing scenarios, albedo sensitivity, ocean heat uptake, and Monte Carlo uncertainty propagation
- R workflows for zero-dimensional energy-balance sensitivity, equilibrium warming tables, and uncertainty summaries
- Julia climate-response scaffolding
- C++ parameter sweeps for energy-balance models
- Fortran radiation and energy-balance tables
- SQL metadata for climate variables, forcing scenarios, model assumptions, physical relations, sources, and simulation runs
- Rust command-line utility for effective emission temperature and CO2 forcing
- C low-level energy-balance table example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Absorbed shortwave radiation:

ASR = S0(1 - alpha)/4

Outgoing blackbody radiation:

OLR = sigma T^4

Effective emission temperature:

Te = [S0(1 - alpha)/(4 sigma)]^(1/4)

Energy imbalance:

N = ASR - OLR

Linearized energy balance:

N = F - lambda DeltaT

Equilibrium response:

DeltaT_eq = F/lambda

One-layer time-dependent energy-balance model:

C dT/dt = F(t) - lambda T

Two-layer model:

Cu dTu/dt = F(t) - lambda Tu - kappa(Tu - Td)

Cd dTd/dt = kappa(Tu - Td)

Approximate CO2 radiative forcing:

DeltaF = 5.35 ln(C/C0)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/climate-physics-and-planetary-energy-balance
