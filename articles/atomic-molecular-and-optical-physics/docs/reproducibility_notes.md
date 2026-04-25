# Reproducibility Notes

## Data

Primary sample datasets:

- data/amo_constants.csv
- data/hydrogen_series_cases.csv
- data/molecular_rotor_cases.csv
- data/rabi_parameter_cases.csv
- data/spectral_line_samples.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants and units
2. compute hydrogen transition wavelengths
3. convert wavelength to photon energy and frequency
4. classify approximate spectral regions
5. compute molecular rotational energies
6. compute Boltzmann rotational populations
7. simulate ideal two-level Rabi oscillations
8. fit a simple Gaussian spectral line
9. store AMO constants, transitions, sources, assumptions, and runs in SQL
10. extend examples into richer AMO workflows

## Possible Extensions

Future expansions could include:

- fine-structure corrections
- hyperfine splitting scaffolds
- Zeeman splitting examples
- Stark shift examples
- isotope shift examples
- Voigt line profile fitting
- density-matrix optical Bloch equations
- spontaneous decay and decoherence
- laser cooling force model
- Doppler broadening and temperature inference
- optical lattice band structure
- cold-atom time-of-flight expansion
- Ramsey spectroscopy
- atomic clock instability metrics
