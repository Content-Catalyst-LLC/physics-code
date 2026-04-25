# Reproducibility Notes

## Data

Primary sample datasets:

- data/qubit_state_cases.csv
- data/decoherence_parameter_cases.csv
- data/measurement_basis_cases.csv
- data/channel_catalog.csv
- data/error_correction_cases.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect qubit state parameters
2. construct normalized state vectors
3. build density matrices
4. compute Born-rule measurement probabilities
5. simulate pure dephasing
6. simulate amplitude damping
7. compute purity and von Neumann entropy
8. compute Bell-state reduced density matrices and entanglement entropy
9. run simple bit-flip code syndrome logic
10. store assumptions, states, channels, measurements, and sources in SQL
11. extend examples into richer quantum-information workflows

## Possible Extensions

Future expansions could include:

- optical Bloch equations
- Lindblad master equation
- depolarizing channel
- phase-flip channel
- Kraus-operator validation checks
- process tomography scaffold
- state tomography scaffold
- stabilizer tableau simulator
- Shor code demonstration
- surface code toy model
- quantum teleportation circuit state tracking
- CHSH inequality simulation
- Ramsey decoherence experiment
- gate fidelity and randomized benchmarking scaffold
