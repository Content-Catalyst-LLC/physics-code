# Reproducibility Notes

## Data

Primary sample datasets:

- data/radiation_constants.csv
- data/spectral_bands.csv
- data/interference_setup.csv
- data/blackbody_temperatures.csv
- data/source_metadata.csv
- data/radiation_model_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants used in radiation calculations
2. convert wavelength, frequency, and photon energy
3. compute double-slit interference patterns
4. compute diffraction-style envelopes
5. compute Planck spectral-radiance curves
6. estimate Wien peak wavelengths
7. compute Stefan-Boltzmann total exitance
8. store spectral-band and model metadata in SQL
9. extend the examples into richer optics and radiation workflows

## Possible Extensions

Future expansions could include:

- single-slit diffraction
- Airy disk diffraction
- coherence length from linewidth
- spectral calibration uncertainty
- atmospheric transmission curves
- remote-sensing bandpass integration
- photometric vs radiometric unit conversions
- detector quantum efficiency
- polarization Jones-vector scaffolds
- Fourier optics examples
