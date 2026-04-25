# Atomic, Molecular, and Optical Physics

This folder supports the Physics knowledge-series article **Atomic, Molecular, and Optical Physics**.

The article examines atomic structure, molecular spectra, optical transitions, hydrogen-like energy levels, the Rydberg formula, angular momentum, selection rules, fine and hyperfine structure, Zeeman and Stark effects, spectroscopy, spontaneous and stimulated emission, lasers, Rabi oscillations, quantum optics, cold atoms, optical traps, precision clocks, quantum technologies, and computational AMO workflows.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible AMO-physics workflows.

## Included Materials

- Python workflows for hydrogen spectra, photon energy conversion, two-level Rabi oscillations, molecular rotational spectra, spectral line fitting, and uncertainty propagation
- R workflows for Boltzmann rotational populations, spectral line summaries, and transition-table analysis
- Julia AMO calculation scaffolding
- C++ Rydberg spectral sweeps
- Fortran transition and radiation tables
- SQL metadata for atomic states, molecular levels, optical transitions, constants, assumptions, sources, and simulation runs
- Rust command-line utility for photon transition conversion
- C low-level hydrogen spectrum example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Photon energy:

E = h nu

Wavelength-frequency relation:

c = lambda nu

Photon energy by wavelength:

E = h c / lambda

Hydrogen-like leading energy levels:

E_n = -13.6 eV / n^2

Rydberg formula:

1/lambda = R_H(1/n_lower^2 - 1/n_upper^2)

Rigid rotor:

E_J = B J(J + 1)

Molecular harmonic oscillator:

E_v = hbar omega(v + 1/2)

Boltzmann population ratio:

N_i/N_j = (g_i/g_j) exp[-(E_i - E_j)/(k_B T)]

Driven two-level excited-state probability:

P_e(t) = [Omega^2/(Omega^2 + Delta^2)] sin^2(sqrt(Omega^2 + Delta^2)t/2)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/atomic-molecular-and-optical-physics
