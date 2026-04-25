# Methodology Notes

## Purpose

This repository folder supports an article on quantum information, decoherence, and measurement by translating qubit states, density matrices, measurement probabilities, quantum channels, decoherence diagnostics, entropy, and simple quantum error-correction logic into reproducible computational workflows.

The goal is not to replace professional quantum SDKs, open-system solvers, tensor-network libraries, quantum hardware calibration stacks, or full fault-tolerance simulations. The goal is to provide transparent scaffolding for:

- qubit state representation
- density matrix construction
- Born-rule measurement probabilities
- Bloch vector diagnostics
- pure dephasing channels
- amplitude damping channels
- Bell states and entanglement entropy
- binary entropy and measurement uncertainty
- simple bit-flip error-correction logic
- quantum-information metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Qubits

|psi> = alpha|0> + beta|1>

|alpha|^2 + |beta|^2 = 1

### Density Matrices

rho = |psi><psi|

rho = sum_i p_i |psi_i><psi_i|

### Measurement

p_i = Tr(P_i rho)

rho_i' = P_i rho P_i / Tr(P_i rho)

### Channels

E(rho) = sum_i K_i rho K_i dagger

sum_i K_i dagger K_i = I

### Decoherence

rho_01(t) = rho_01(0) exp(-t/T2)

P_e(t) = P_e(0) exp(-t/T1)

### Entropy

S(rho) = -Tr(rho log2 rho)

## Assumptions

The introductory workflows assume:

- ideal two-level qubit systems
- dimensionless state vectors and density matrices
- simplified pure dephasing and amplitude damping channels
- no hardware-specific calibration model
- no pulse-level control
- no many-qubit tensor-network optimization
- no full Lindblad master-equation solver in introductory scripts
- no production quantum error-correction simulation
- no formal threshold analysis

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for Qiskit, Cirq, QuTiP, PennyLane, TensorFlow Quantum, hardware-control software, research-grade master-equation solvers, or fault-tolerant quantum-computing simulators.

## Computational Philosophy

The code is organized by scientific role:

- Python: density matrices, channels, entropy, measurement, Bell states, simple codes
- R: entropy and measurement uncertainty tables
- Julia: compact qubit calculations
- C++: performance-oriented channel sweeps
- Fortran: classic scientific-computing density-matrix tables
- SQL: structured metadata for states, measurements, channels, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
