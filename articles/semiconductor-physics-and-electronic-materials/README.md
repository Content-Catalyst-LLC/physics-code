# Semiconductor Physics and Electronic Materials

This folder supports the Physics knowledge-series article **Semiconductor Physics and Electronic Materials**.

The article examines crystal lattices, band structure, band gaps, effective mass, density of states, Fermi-Dirac statistics, intrinsic and extrinsic semiconductors, doping, carrier concentration, mobility, conductivity, drift, diffusion, recombination, p-n junctions, depletion regions, built-in potential, diode current, metal-semiconductor contacts, MOS capacitors, MOSFET physics, electronic materials, defects, strain, interfaces, heterostructures, compound semiconductors, wide-bandgap materials, optoelectronic materials, semiconductor metrology, and computational semiconductor modeling.

## Repository Purpose

This folder provides advanced research-style computational scaffolding for extending the article's selected examples into reproducible semiconductor-physics workflows.

## Included Materials

- Python workflows for diode I-V curves, intrinsic carrier concentration, p-n junction electrostatics, MOS capacitance, mobility models, and Fermi-level diagnostics
- R workflows for conductivity sensitivity, doping sweeps, and resistivity summaries
- Julia semiconductor calculation scaffolding
- C++ transport and diode parameter sweeps
- Fortran junction and conductivity tables
- SQL metadata for materials, constants, dopants, devices, relations, sources, assumptions, and simulation runs
- Rust command-line utility for carrier concentration and conductivity
- C low-level diode and conductivity table examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Band gap:

Eg = Ec - Ev

Fermi-Dirac distribution:

f(E) = 1/[1 + exp((E - EF)/(kB T))]

Intrinsic carrier concentration:

ni = sqrt(Nc Nv) exp[-Eg/(2 kB T)]

Mass-action relation:

np = ni^2

Conductivity:

sigma = q(n mu_n + p mu_p)

Einstein relation:

D = mu kB T / q

Built-in potential:

Vbi = (kB T/q) ln(NA ND / ni^2)

Ideal diode equation:

I = Is[exp(qV/(n kB T)) - 1]

Oxide capacitance per area:

Cox = epsilon_ox / t_ox

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/semiconductor-physics-and-electronic-materials
