# Reproducibility Notes

## Data

Primary sample datasets:

- data/many_body_constants.csv
- data/hilbert_space_cases.csv
- data/occupation_cases.csv
- data/spin_chain_cases.csv
- data/many_body_model_cases.csv
- data/phase_examples.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants and unit conventions
2. compute Hilbert-space growth
3. compare Bose and Fermi occupation statistics
4. build small spin-chain Hamiltonians
5. compute finite-system spectra
6. estimate simple connected correlations
7. compute entanglement entropy scaffolds
8. generate structure-factor scaffolds
9. store Hamiltonian, model, phase, source, and simulation metadata in SQL
10. extend examples into richer many-body workflows

## Possible Extensions

Future expansions could include:

- sparse exact diagonalization
- symmetry-sector block diagonalization
- transverse-field Ising correlation functions
- Heisenberg spin-chain exact diagonalization
- small Hubbard-model exact diagonalization
- density matrix renormalization group notes
- matrix product state toy implementation
- quantum Monte Carlo scaffold
- tensor-network metadata
- many-body localization toy model
- Floquet spin-chain toy model
- entanglement spectrum
- dynamic structure factor
- spectral function
- Green's function examples
- mean-field self-consistency solvers
