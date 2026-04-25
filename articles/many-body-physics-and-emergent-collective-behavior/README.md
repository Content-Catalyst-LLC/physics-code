# Many-Body Physics and Emergent Collective Behavior

This folder supports the Physics knowledge-series article **Many-Body Physics and Emergent Collective Behavior**.

The article examines interacting particles, quantum statistics, identical particles, Hilbert-space growth, second quantization, Fock space, correlation functions, entanglement, quasiparticles, phonons, magnons, Fermi liquids, Bose condensation, superfluidity, superconductivity, magnetism, the Hubbard model, strongly correlated systems, topological order, nonequilibrium many-body dynamics, numerical methods, and the meaning of emergence in physical science.

## Repository Purpose

This folder provides advanced computational scaffolding for extending the article's selected examples into reproducible many-body physics workflows.

## Included Materials

- Python workflows for Hilbert-space scaling, exact diagonalization, spin-chain spectra, correlation functions, entanglement entropy, occupation statistics, and structure factors
- R workflows for Bose/Fermi occupation statistics and Hilbert-space growth summaries
- Julia many-body calculation scaffolding
- C++ spin-chain and Hilbert-space sweeps
- Fortran Hilbert-space tables
- SQL metadata for Hamiltonians, operators, models, phases, assumptions, sources, and simulation runs
- Rust command-line utility for Hilbert-space and occupation calculations
- C low-level Hilbert-space and occupation examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Many-body Hamiltonian:

H = sum_i h_i + sum_{i<j} V_ij

Spin-1/2 Hilbert-space dimension:

dim H = 2^N

Fermi-Dirac occupation:

f(E) = 1/(exp((E - mu)/(k_B T)) + 1)

Bose-Einstein occupation:

n(E) = 1/(exp((E - mu)/(k_B T)) - 1)

Hubbard model:

H = -t sum_<i,j>,sigma (c_i_sigma dagger c_j_sigma + h.c.) + U sum_i n_i_up n_i_down

Heisenberg model:

H = J sum_<i,j> S_i dot S_j

Connected correlation:

C_ij = <O_i O_j> - <O_i><O_j>

Entanglement entropy:

S_A = -Tr(rho_A ln rho_A)

Partition function:

Z = Tr(exp(-beta H))

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/many-body-physics-and-emergent-collective-behavior
