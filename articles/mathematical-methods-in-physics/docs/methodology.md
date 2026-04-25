# Methodology Notes

## Purpose

This repository folder supports an article on mathematical methods in physics by translating core mathematical structures into reproducible computational workflows.

The goal is not to replace full mathematical physics textbooks, symbolic algebra systems, PDE solver libraries, numerical analysis packages, or scientific computing frameworks. The goal is to provide transparent scaffolding for:

- dimensional analysis
- unit-aware physical quantities
- ODE integration
- eigenvalue problems
- Fourier analysis
- uncertainty propagation
- vector and tensor operations
- PDE grid scaffolds
- numerical-method diagnostics
- mathematical-physics metadata
- source provenance
- reproducibility documentation

## Core Ideas

### Calculus

v = dx/dt

a = d2x/dt2

W = integral F dot dr

### Vector Calculus

grad phi

div F

curl F

laplacian phi

### Conservation

partial rho/partial t + div J = 0

### Linear Algebra

A x = b

A v = lambda v

### Differential Equations

dx/dt = F(x,t)

partial u/partial t = D laplacian u

partial2 u/partial t2 = c^2 laplacian u

### Fourier Analysis

fhat(omega) = integral f(t) exp(-i omega t) dt

### Probability and Uncertainty

E[X] = integral x p(x) dx

Var(X) = E[(X - mu)^2]

sigma_f^2 = sum_i (partial f/partial x_i)^2 sigma_i^2

### Variational Methods

delta S = 0

## Assumptions

The introductory workflows assume:

- SI units unless otherwise stated
- simple harmonic oscillator examples for ODE and Fourier demonstrations
- small synthetic datasets for clarity
- linear algebra examples based on small matrices
- first-order uncertainty propagation
- simple finite-difference grids for PDE scaffolding
- no production PDE solver
- no full unit algebra library
- no symbolic tensor calculus framework
- no high-performance solver optimization

## Limitations

These workflows are teaching and scaffolding tools. They are not substitutes for Mathematica, Maple, MATLAB, NumPy/SciPy production pipelines, PETSc, FEniCS, Dedalus, deal.II, Julia DifferentialEquations, or specialized physics simulation software.

## Computational Philosophy

The code is organized by scientific role:

- Python: ODEs, eigenvalues, FFTs, tensors, finite differences, symbolic scaffolds
- R: uncertainty propagation, unit tables, parameter summaries, statistical diagnostics
- Julia: compact numerical-methods examples
- C++: performance-oriented finite-difference loops
- Fortran: classic scientific-computing numerical tables
- SQL: structured metadata for methods, equations, variables, assumptions, and sources
- Rust: safe command-line utility
- C: low-level numerical calculations
