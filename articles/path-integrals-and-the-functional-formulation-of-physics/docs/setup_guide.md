# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/path-integrals-and-the-functional-formulation-of-physics/python/euclidean_oscillator_monte_carlo.py
    python articles/path-integrals-and-the-functional-formulation-of-physics/python/discretized_path_actions.py
    python articles/path-integrals-and-the-functional-formulation-of-physics/python/gaussian_integral_diagnostics.py
    python articles/path-integrals-and-the-functional-formulation-of-physics/python/generating_functional_scaffold.py
    python articles/path-integrals-and-the-functional-formulation-of-physics/python/lattice_scalar_field_scaffold.py
    python articles/path-integrals-and-the-functional-formulation-of-physics/python/stochastic_path_scaffold.py

## R

From the repository root:

    Rscript articles/path-integrals-and-the-functional-formulation-of-physics/r/discretized_euclidean_action.R
    Rscript articles/path-integrals-and-the-functional-formulation-of-physics/r/path_action_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/path-integrals-and-the-functional-formulation-of-physics/julia/path_integral_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/path-integrals-and-the-functional-formulation-of-physics/cpp/euclidean_action_sweep.cpp -o euclidean_action_sweep
    ./euclidean_action_sweep

## Fortran

Compile and run:

    gfortran articles/path-integrals-and-the-functional-formulation-of-physics/fortran/discretized_action_table.f90 -o discretized_action_table
    ./discretized_action_table

## SQL

Run with SQLite:

    sqlite3 articles/path-integrals-and-the-functional-formulation-of-physics/data/path_integrals.sqlite < articles/path-integrals-and-the-functional-formulation-of-physics/sql/path_integrals_schema.sql

## Rust

Compile and run:

    rustc articles/path-integrals-and-the-functional-formulation-of-physics/rust/path_integral_cli.rs -o path_integral_cli
    ./path_integral_cli

## C

Compile and run:

    gcc articles/path-integrals-and-the-functional-formulation-of-physics/c/euclidean_action_table.c -o euclidean_action_table_c -lm
    ./euclidean_action_table_c
