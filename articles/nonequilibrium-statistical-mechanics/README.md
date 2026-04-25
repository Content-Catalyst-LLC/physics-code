# Nonequilibrium Statistical Mechanics

This folder supports the Physics knowledge-series article **Nonequilibrium Statistical Mechanics**.

The article examines microscopic reversibility, macroscopic irreversibility, Liouville dynamics, BBGKY hierarchy, Boltzmann equation, H-theorem, master equations, detailed balance, Markov processes, Langevin equations, Fokker-Planck equations, Brownian motion, fluctuation-dissipation relations, Onsager reciprocity, Green-Kubo formulas, entropy production, nonequilibrium steady states, stochastic thermodynamics, fluctuation theorems, Jarzynski equality, Crooks relation, kinetic theory, hydrodynamic limits, transport coefficients, reaction networks, active matter, driven systems, glassy relaxation, and computational stochastic workflows.

## Repository Purpose

This folder provides computational scaffolding for extending the article's selected examples into reproducible nonequilibrium statistical mechanics workflows.

## Included Materials

- Python workflows for overdamped Langevin dynamics, Fokker-Planck relaxation, Green-Kubo estimates, entropy production, and fluctuation-theorem checks
- R workflows for Markov jump processes, stationary distributions, probability currents, and entropy production
- Julia stochastic-process calculation scaffolding
- C++ trajectory simulation
- Fortran diffusion and relaxation tables
- SQL metadata for rates, forces, fluxes, assumptions, sources, and simulation runs
- Rust command-line utility for Markov-cycle entropy production
- C low-level stochastic-process examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Liouville equation:

partial rho / partial t + {rho,H} = 0

Boltzmann equation:

partial f / partial t + v dot grad_x f + F/m dot grad_v f = C[f]

Master equation:

dp_i/dt = sum_j (W_ij p_j - W_ji p_i)

Detailed balance:

W_ij p_j^eq = W_ji p_i^eq

Overdamped Langevin equation:

dx = mu F(x) dt + sqrt(2D) dW_t

Fokker-Planck equation:

partial P / partial t = -partial_x[mu F P] + D partial_x^2 P

Einstein relation:

D = mu k_B T

Linear response:

J_i = sum_j L_ij X_j

Onsager reciprocity:

L_ij = L_ji

Markov entropy production:

Sdot = 1/2 sum_ij (W_ij p_j - W_ji p_i) log((W_ij p_j)/(W_ji p_i))

Jarzynski equality:

<exp(-beta W)> = exp(-beta Delta F)

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/nonequilibrium-statistical-mechanics
