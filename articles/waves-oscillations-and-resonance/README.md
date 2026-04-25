# Waves, Oscillations, and Resonance

This folder supports the Physics knowledge-series article **Waves, Oscillations, and Resonance**.

The article examines simple harmonic motion, damping, driven oscillators, resonance, phase, frequency, amplitude, coupled oscillators, normal modes, mechanical waves, the wave equation, wave speed, standing waves, interference, beats, Fourier decomposition, dispersion, sound, light, and the role of wave reasoning across physics.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible wave-physics workflows.

## Included Materials

- Python workflows for damped and driven oscillator simulation, resonance sweeps, wave-equation scaffolds, standing-wave modes, and Fourier decomposition
- R workflows for resonance curves, oscillator response tables, wave-speed summaries, and frequency-domain diagnostics
- Julia oscillator and wave scaffolding
- C++ resonance parameter sweeps
- Fortran standing-wave and oscillator tables
- SQL metadata for oscillators, wave systems, modes, sources, assumptions, and simulation runs
- Rust command-line utility for oscillator and wave calculations
- C low-level resonance table example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Hooke's law:

F = -kx

Simple harmonic oscillator:

d2x/dt2 + omega0^2 x = 0

Natural angular frequency:

omega0 = sqrt(k/m)

Simple harmonic motion:

x(t) = A cos(omega0 t + phi)

Period:

T = 2 pi / omega0

Frequency:

f = 1/T = omega0/(2 pi)

Damped oscillator:

d2x/dt2 + 2 gamma dx/dt + omega0^2 x = 0

Driven damped oscillator:

d2x/dt2 + 2 gamma dx/dt + omega0^2 x = (F0/m) cos(omega t)

Steady-state amplitude:

A(omega) = (F0/m) / sqrt((omega0^2 - omega^2)^2 + (2 gamma omega)^2)

Traveling wave:

y(x,t) = A cos(kx - omega t + phi)

Wavelength:

lambda = 2 pi / k

Wave speed:

v = omega/k = f lambda

Wave equation:

d2y/dt2 = v^2 d2y/dx2

String wave speed:

v = sqrt(T/mu)

Standing-wave wavelengths on fixed string:

lambda_n = 2L/n

Standing-wave frequencies:

f_n = n v/(2L)

Beat frequency:

f_beat = |f1 - f2|

Group velocity:

v_g = d omega / d k

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/waves-oscillations-and-resonance
