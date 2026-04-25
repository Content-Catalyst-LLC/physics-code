# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/numerical-methods-in-physics/python/finite_difference_convergence.py
    python articles/numerical-methods-in-physics/python/heat_equation_ftcs.py
    python articles/numerical-methods-in-physics/python/ode_integrator_comparison.py
    python articles/numerical-methods-in-physics/python/sparse_poisson_1d.py
    python articles/numerical-methods-in-physics/python/monte_carlo_pi.py
    python articles/numerical-methods-in-physics/python/eigenvalue_schrodinger_well.py

## R

From the repository root:

    Rscript articles/numerical-methods-in-physics/r/finite_difference_convergence.R
    Rscript articles/numerical-methods-in-physics/r/error_order_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/numerical-methods-in-physics/julia/numerical_methods_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/numerical-methods-in-physics/cpp/finite_difference_sweep.cpp -o finite_difference_sweep
    ./finite_difference_sweep

## Fortran

Compile and run:

    gfortran articles/numerical-methods-in-physics/fortran/convergence_table.f90 -o convergence_table
    ./convergence_table

## SQL

Run with SQLite:

    sqlite3 articles/numerical-methods-in-physics/data/numerical_methods.sqlite < articles/numerical-methods-in-physics/sql/numerical_methods_schema.sql

## Rust

Compile and run:

    rustc articles/numerical-methods-in-physics/rust/numerics_cli.rs -o numerics_cli
    ./numerics_cli

## C

Compile and run:

    gcc articles/numerical-methods-in-physics/c/finite_difference_derivative.c -o finite_difference_derivative_c -lm
    ./finite_difference_derivative_c
