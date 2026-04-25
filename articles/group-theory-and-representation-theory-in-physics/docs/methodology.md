# Methodology Notes

## Purpose

This repository folder supports an article on group theory and representation theory in physics by translating finite-group characters, irreducible decomposition, angular-momentum matrices, Lie-algebra commutators, tensor-product scaffolds, point-group metadata, and representation checks into reproducible computational workflows.

The goal is not to replace mature symbolic algebra, crystallographic, Lie-theory, electronic-structure, or particle-physics packages. The goal is to provide transparent scaffolding for:

- finite-group character tables
- character orthogonality
- reducible-representation decomposition
- representation matrix checks
- angular-momentum matrices
- SU(2) commutators
- Casimir diagnostics
- Lie-algebra commutator tables
- tensor-product decomposition metadata
- point-group and selection-rule metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Representation

D(gh) = D(g)D(h)

### Character

chi(g) = Tr D(g)

### Character Inner Product

<chi_a, chi_b> = (1/|G|) sum_g conjugate(chi_a(g)) chi_b(g)

### Irreducible Multiplicity

n_a = (1/|G|) sum_g conjugate(chi_a(g)) chi_Gamma(g)

### Lie Algebra

[T_a, T_b] = i f_ab^c T_c

### Angular Momentum Algebra

[J_i, J_j] = i hbar epsilon_ijk J_k

### SU(2) Casimir

J^2 |j,m> = hbar^2 j(j+1)|j,m>

### Spin-j Dimension

dim(j) = 2j + 1

## Assumptions

The introductory workflows assume:

- finite groups where character sums are used
- complex irreducible characters for the C3 examples
- hbar = 1 in most angular-momentum code examples
- exact symbolic or numerical matrices only at teaching scale
- simplified point-group metadata rather than a full crystallographic database
- educational tensor-product scaffolds rather than full Clebsch-Gordan tables
- no production electronic-structure or particle-physics computation

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for GAP, SageMath, Mathematica, SymPy Lie-algebra tools, Bilbao Crystallographic Server, spglib, pymatgen, Quantum ESPRESSO, FeynRules, LieART, or validated research pipelines.

## Computational Philosophy

The code is organized by scientific role:

- Python: angular momentum, representation checks, Lie commutators, tensor-product scaffolds
- R: character tables, orthogonality, finite-group decomposition
- Julia: compact group-theory calculations
- C++: performance-oriented representation sweeps
- Fortran: classic scientific-computing character tables
- SQL: structured metadata for groups, irreps, generators, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
