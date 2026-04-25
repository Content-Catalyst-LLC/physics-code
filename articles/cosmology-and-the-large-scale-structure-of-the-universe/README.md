# Cosmology and the Large-Scale Structure of the Universe

This folder supports the Physics knowledge-series article **Cosmology and the Large-Scale Structure of the Universe**.

The article examines the cosmological principle, FLRW spacetime, scale factor, redshift, Hubble expansion, Friedmann equations, cosmic density parameters, radiation, baryons, cold dark matter, dark energy, inflation, primordial perturbations, the cosmic microwave background, acoustic peaks, baryon acoustic oscillations, galaxy surveys, weak lensing, large-scale structure, cosmic web morphology, linear perturbation growth, transfer functions, matter power spectra, halo formation, N-body simulations, hydrodynamic simulations, parameter inference, observational tensions, and the future of survey cosmology.

## Repository Purpose

This folder provides advanced computational scaffolding for extending the article's selected examples into reproducible cosmology and large-scale-structure workflows.

## Included Materials

- Python workflows for FLRW expansion, distance-redshift relations, growth functions, toy matter power spectra, BAO scales, survey metadata, and simulation summaries
- R workflows for expansion history and cosmological distance tables
- Julia cosmology calculation scaffolding
- C++ distance and expansion sweeps
- Fortran expansion tables
- SQL metadata for cosmological parameters, surveys, observables, simulations, assumptions, sources, and runs
- Rust command-line utility for background expansion calculations
- C low-level expansion and distance examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

FLRW metric:

ds^2 = -c^2 dt^2 + a(t)^2 [dr^2/(1 - k r^2) + r^2 dOmega^2]

Hubble parameter:

H = adot/a

Redshift-scale factor relation:

1 + z = a0/a

Friedmann equation:

H^2 = (8 pi G / 3) rho - k c^2/a^2 + Lambda c^2/3

Flat Lambda-CDM expansion function:

E(z) = sqrt(Omega_r(1+z)^4 + Omega_m(1+z)^3 + Omega_Lambda)

Comoving distance:

chi(z) = c integral_0^z dz'/H(z')

Density contrast:

delta = (rho - rho_bar)/rho_bar

Linear growth equation:

delta_ddot + 2 H delta_dot - 4 pi G rho_bar_m delta = 0

Matter power spectrum:

<delta(k) delta*(k')> = (2pi)^3 delta_D(k-k') P(k)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/cosmology-and-the-large-scale-structure-of-the-universe
