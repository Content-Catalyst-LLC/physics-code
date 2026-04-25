# Reproducibility Notes

## Data

Primary sample datasets:

- data/semiconductor_constants.csv
- data/material_parameter_cases.csv
- data/doping_mobility_cases.csv
- data/diode_parameter_cases.csv
- data/pn_junction_cases.csv
- data/mos_oxide_cases.csv
- data/model_metadata.csv
- data/source_metadata.csv

## Reproducibility Goals

A reader should be able to:

1. inspect constants and units
2. compute thermal voltage
3. compute intrinsic carrier concentration
4. estimate conductivity from carrier concentration and mobility
5. compute built-in potential for an abrupt p-n junction
6. compute depletion width under bias
7. generate ideal diode current-voltage tables
8. compute MOS oxide capacitance per area
9. store assumptions, materials, parameters, devices, and sources in SQL
10. extend examples into richer semiconductor-physics workflows

## Possible Extensions

Future expansions could include:

- Fermi-Dirac integral approximations
- incomplete dopant ionization
- temperature-dependent band gap models
- Caughey-Thomas mobility model
- recombination-generation lifetime models
- Shockley-Read-Hall recombination
- drift-diffusion finite-difference solver
- Poisson solver for depletion regions
- MOS threshold voltage model
- C-V curve scaffolding
- Schottky contact barrier models
- heterojunction band offsets
- quantum well energy levels
- photovoltaic diode model
- SPICE-style compact-model parameter export
