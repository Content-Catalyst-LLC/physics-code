# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/many-body-physics-and-emergent-collective-behavior/python/hilbert_space_growth.py
    python articles/many-body-physics-and-emergent-collective-behavior/python/occupation_statistics.py
    python articles/many-body-physics-and-emergent-collective-behavior/python/exact_diagonalization_spin_chain.py
    python articles/many-body-physics-and-emergent-collective-behavior/python/correlation_function_scaffold.py
    python articles/many-body-physics-and-emergent-collective-behavior/python/entanglement_entropy_scaffold.py
    python articles/many-body-physics-and-emergent-collective-behavior/python/structure_factor_scaffold.py

## R

From the repository root:

    Rscript articles/many-body-physics-and-emergent-collective-behavior/r/occupation_statistics.R
    Rscript articles/many-body-physics-and-emergent-collective-behavior/r/hilbert_space_scaling.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/many-body-physics-and-emergent-collective-behavior/julia/many_body_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/many-body-physics-and-emergent-collective-behavior/cpp/spin_chain_sweep.cpp -o spin_chain_sweep
    ./spin_chain_sweep

## Fortran

Compile and run:

    gfortran articles/many-body-physics-and-emergent-collective-behavior/fortran/hilbert_space_table.f90 -o hilbert_space_table
    ./hilbert_space_table

## SQL

Run with SQLite:

    sqlite3 articles/many-body-physics-and-emergent-collective-behavior/data/many_body_physics.sqlite < articles/many-body-physics-and-emergent-collective-behavior/sql/many_body_physics_schema.sql

## Rust

Compile and run:

    rustc articles/many-body-physics-and-emergent-collective-behavior/rust/many_body_cli.rs -o many_body_cli
    ./many_body_cli

## C

Compile and run:

    gcc articles/many-body-physics-and-emergent-collective-behavior/c/hilbert_occupation_table.c -o hilbert_occupation_table_c -lm
    ./hilbert_occupation_table_c
