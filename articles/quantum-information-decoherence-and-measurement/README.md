# Quantum Information, Decoherence, and Measurement

This folder supports the Physics knowledge-series article **Quantum Information, Decoherence, and Measurement**.

The article examines qubits, superposition, Hilbert space, density matrices, pure and mixed states, the Bloch sphere, projective measurement, generalized measurement, the Born rule, entanglement, quantum channels, decoherence, dephasing, relaxation, entropy, no-cloning, teleportation, quantum error correction, fault tolerance, and the measurement problem.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible quantum-information workflows.

## Included Materials

- Python workflows for qubit states, density matrices, Bloch vectors, projective measurement, dephasing channels, amplitude damping, Bell states, entanglement entropy, and simple error-correction logic
- R workflows for binary entropy, measurement uncertainty, decoherence summaries, and qubit diagnostics
- Julia quantum-state calculation scaffolding
- C++ quantum-channel parameter sweeps
- Fortran density-matrix and entropy tables
- SQL metadata for states, measurements, channels, decoherence models, assumptions, sources, and simulation runs
- Rust command-line utility for qubit entropy and dephasing
- C low-level density-matrix dephasing example
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Qubit state:

|psi> = alpha|0> + beta|1>

Normalization:

|alpha|^2 + |beta|^2 = 1

Density matrix:

rho = |psi><psi|

Mixed state:

rho = sum_i p_i |psi_i><psi_i|

Unitary evolution:

rho' = U rho U dagger

Born rule:

p_i = Tr(P_i rho)

Quantum channel:

E(rho) = sum_i K_i rho K_i dagger

Trace preservation:

sum_i K_i dagger K_i = I

Pure dephasing:

rho_01(t) = rho_01(0) exp(-t/T2)

Relaxation:

P_e(t) = P_e(0) exp(-t/T1)

Von Neumann entropy:

S(rho) = -Tr(rho log2 rho)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/quantum-information-decoherence-and-measurement
