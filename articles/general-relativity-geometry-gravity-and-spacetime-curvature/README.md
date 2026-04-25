# General Relativity: Geometry, Gravity, and Spacetime Curvature

This folder supports the Physics knowledge-series article **General Relativity: Geometry, Gravity, and Spacetime Curvature**.

The article examines the equivalence principle, spacetime intervals, Lorentzian geometry, metric tensors, geodesics, covariant derivatives, curvature, the Riemann tensor, Ricci curvature, scalar curvature, Einstein's field equation, the stress-energy tensor, Newtonian limits, Schwarzschild geometry, gravitational time dilation, light bending, black holes, horizons, gravitational waves, cosmology, experimental tests, numerical relativity, and the unresolved tension between general relativity and quantum theory.

## Repository Purpose

This folder provides advanced computational scaffolding for extending the article's selected examples into reproducible general-relativity workflows.

## Included Materials

- Python workflows for Schwarzschild scales, weak-field precession, geodesic diagnostics, curvature metadata, gravitational redshift, and cosmology
- R workflows for Schwarzschild radius, gravitational redshift, compactness, and relativistic scale summaries
- Julia relativity calculation scaffolding
- C++ weak-field orbit parameter sweeps
- Fortran Schwarzschild and redshift tables
- SQL metadata for constants, metrics, relations, tests, assumptions, sources, and simulation runs
- Rust command-line utility for Schwarzschild and redshift calculations
- C low-level relativity scale examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Metric interval:

ds^2 = g_mu_nu dx^mu dx^nu

Geodesic equation:

d^2x^mu/dlambda^2 + Gamma^mu_alpha_beta dx^alpha/dlambda dx^beta/dlambda = 0

Christoffel symbols:

Gamma^mu_alpha_beta = 1/2 g^mu_nu (partial_alpha g_nu_beta + partial_beta g_nu_alpha - partial_nu g_alpha_beta)

Einstein field equation:

G_mu_nu + Lambda g_mu_nu = (8 pi G/c^4) T_mu_nu

Schwarzschild radius:

r_s = 2 G M / c^2

Gravitational redshift factor:

1 + z = 1/sqrt(1 - r_s/r)

Weak-field light deflection:

Delta phi approx 4 G M/(b c^2)

Friedmann equation:

H^2 = (8 pi G/3) rho - k c^2/a^2 + Lambda c^2/3

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/general-relativity-geometry-gravity-and-spacetime-curvature
