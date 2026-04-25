# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas sympy scipy matplotlib
    python articles/symmetry-conservation-and-noethers-theorem/python/central_force_angular_momentum.py
    python articles/symmetry-conservation-and-noethers-theorem/python/harmonic_oscillator_energy.py
    python articles/symmetry-conservation-and-noethers-theorem/python/symbolic_noether_charge.py
    python articles/symmetry-conservation-and-noethers-theorem/python/field_theory_current_example.py
    python articles/symmetry-conservation-and-noethers-theorem/python/quantum_generators.py

## R

From the repository root:

    Rscript articles/symmetry-conservation-and-noethers-theorem/r/symmetry_conservation_map.R
    Rscript articles/symmetry-conservation-and-noethers-theorem/r/conservation_law_metadata.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/symmetry-conservation-and-noethers-theorem/julia/symmetry_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/symmetry-conservation-and-noethers-theorem/cpp/central_force_sweep.cpp -o central_force_sweep
    ./central_force_sweep

## Fortran

Compile and run:

    gfortran articles/symmetry-conservation-and-noethers-theorem/fortran/conservation_table.f90 -o conservation_table
    ./conservation_table

## SQL

Run with SQLite:

    sqlite3 articles/symmetry-conservation-and-noethers-theorem/data/symmetry_noether.sqlite < articles/symmetry-conservation-and-noethers-theorem/sql/symmetry_noether_schema.sql

## Rust

Compile and run:

    rustc articles/symmetry-conservation-and-noethers-theorem/rust/noether_cli.rs -o noether_cli
    ./noether_cli

## C

Compile and run:

    gcc articles/symmetry-conservation-and-noethers-theorem/c/conservation_table.c -o conservation_table_c -lm
    ./conservation_table_c
