# Scattering Theory, Cross Sections, and Physical Inference

This folder supports the Physics knowledge-series article **Scattering Theory, Cross Sections, and Physical Inference**.

The article examines scattering amplitudes, differential cross sections, total cross sections, probability current, flux, the S-matrix, T-matrix, Born approximation, partial-wave expansion, phase shifts, optical theorem, resonances, Breit-Wigner forms, inelastic scattering, coupled channels, Rutherford scattering, quantum field theory scattering, Feynman amplitudes, luminosity, event rates, detector efficiency, acceptance, unfolding, likelihood inference, uncertainty, inverse scattering, and computational modeling.

## Repository Purpose

This folder provides computational scaffolding for extending the article's selected examples into reproducible scattering-theory, cross-section, and inference workflows.

## Included Materials

- Python workflows for Breit-Wigner resonance fitting, angular cross-section integration, Born approximation examples, partial-wave tables, optical-theorem checks, event-rate inference, detector smearing, and likelihood estimation
- R workflows for angular integration and cross-section summaries
- Julia scattering calculation scaffolding
- C++ cross-section parameter sweeps
- Fortran angular integration tables
- SQL metadata for scattering models, parameters, detector corrections, assumptions, sources, and runs
- Rust command-line utility for simple cross-section and event-rate calculations
- C low-level angular integration examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Asymptotic scattering wavefunction:

psi(r) ~ exp(ikz) + f(theta,phi) exp(ikr)/r

Differential cross section:

d sigma / d Omega = |f(theta,phi)|^2

Total cross section:

sigma_total = integral (d sigma / d Omega) d Omega

Azimuthal integration:

sigma_total = 2 pi integral_0^pi (d sigma / d Omega)(theta) sin(theta) d theta

Born approximation:

f(q) = -m/(2 pi hbar^2) integral exp(-i q dot r) V(r) d^3r

Partial-wave scattering amplitude:

f(theta) = (1/k) sum_l (2l+1) exp(i delta_l) sin(delta_l) P_l(cos theta)

Elastic partial-wave total cross section:

sigma_el = (4 pi/k^2) sum_l (2l+1) sin^2(delta_l)

Optical theorem:

sigma_total = (4 pi/k) Im f(0)

Breit-Wigner resonance:

sigma(E) = sigma_0 (Gamma^2/4)/((E-E_R)^2 + Gamma^2/4)

Event count:

N_obs = L_int sigma epsilon A + N_background

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/scattering-theory-cross-sections-and-physical-inference
