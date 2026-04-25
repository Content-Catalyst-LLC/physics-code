# Group Theory and Representation Theory in Physics

This folder supports the Physics knowledge-series article **Group Theory and Representation Theory in Physics**.

The article examines groups, subgroups, cosets, conjugacy classes, group actions, representations, irreducible representations, characters, Schur's lemma, tensor products, direct sums, Lie groups, Lie algebras, generators, commutators, SO(3), SU(2), angular momentum, spinors, Lorentz and Poincare symmetry, gauge groups, internal symmetries, particle multiplets, point groups, space groups, Bloch theory, tensors, selection rules, and computational representation workflows.

## Repository Purpose

This folder provides advanced computational scaffolding for extending the article's selected examples into reproducible symmetry and representation-theory workflows.

## Included Materials

- Python workflows for angular-momentum matrices, Lie-algebra commutators, representation checks, character-table decomposition, tensor-product scaffolds, and point-group metadata
- R workflows for finite-group character tables, character orthogonality, and irreducible decomposition
- Julia group-theory calculation scaffolding
- C++ representation and angular-momentum sweeps
- Fortran character-table examples
- SQL metadata for groups, irreducible representations, generators, commutators, point groups, assumptions, sources, and simulation runs
- Rust command-line utility for character and angular-momentum calculations
- C low-level finite-group and representation examples
- reproducible sample datasets
- setup, methodology, and reproducibility documentation

## Core Relations

Representation:

D(gh) = D(g)D(h)

Character:

chi(g) = Tr D(g)

Finite-group character inner product:

<chi_a, chi_b> = (1/|G|) sum_g conjugate(chi_a(g)) chi_b(g)

Irreducible multiplicity:

n_a = (1/|G|) sum_g conjugate(chi_a(g)) chi_Gamma(g)

Lie algebra:

[T_a, T_b] = i f_ab^c T_c

Angular momentum algebra:

[J_i, J_j] = i hbar epsilon_ijk J_k

Angular momentum Casimir:

J^2 |j,m> = hbar^2 j(j+1)|j,m>

SU(2) representation dimension:

dim(j) = 2j + 1

Gauge-covariant derivative:

D_mu = partial_mu + i g A_mu^a T_a

## Article Repository URL

https://github.com/Content-Catalyst-LLC/physics-code/tree/main/articles/group-theory-and-representation-theory-in-physics
