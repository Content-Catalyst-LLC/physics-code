# Light, Waves, and the Physics of Radiation

This folder supports the Physics knowledge-series article **Light, Waves, and the Physics of Radiation**.

The article examines wave structure, wavelength, frequency, speed, coherence, phase, superposition, interference, diffraction, polarization, electromagnetic radiation, the electromagnetic spectrum, energy flux, blackbody radiation, Planck's law, Wien's displacement law, Stefan-Boltzmann scaling, and the transition from classical radiation theory to quantum physics.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible wave, optics, and radiation workflows.

## Included Materials

- Python workflows for double-slit interference, diffraction envelopes, Planck spectra, Wien peaks, Stefan-Boltzmann scaling, and spectral-band metadata
- R workflows for blackbody spectra, interference scans, and radiation-law summaries
- Julia spectral-radiance and Wien-law scaffold
- C++ parameter sweeps for Planck spectra and double-slit intensity
- Fortran wave-relation and radiation-law table generation
- SQL metadata for spectral bands, constants, radiation models, interference setups, source notes, model assumptions, and simulation runs
- Rust command-line utility for wavelength-frequency-energy conversion
- C low-level Planck-law table example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Wave relation:

v = f lambda

Electromagnetic wave relation in vacuum:

c = f lambda

Monochromatic wave:

y(x,t) = A sin(kx - omega t + phi)

Wavenumber:

k = 2 pi / lambda

Angular frequency:

omega = 2 pi f

Double-slit bright-fringe condition:

Delta = m lambda

Double-slit small-angle fringe position:

y_m = m lambda L / d

Poynting vector:

S = (1/mu_0) E x B

Planck spectral radiance:

B_lambda(T) = (2 h c^2 / lambda^5) / [exp(h c / (lambda k_B T)) - 1]

Stefan-Boltzmann law:

M = sigma T^4

Wien displacement law:

lambda_max T = b

Photon energy:

E = h f = h c / lambda

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/light-waves-and-the-physics-of-radiation
