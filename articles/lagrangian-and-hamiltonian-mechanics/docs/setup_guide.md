# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib sympy
    python articles/lagrangian-and-hamiltonian-mechanics/python/hamiltonian_pendulum_symplectic.py
    python articles/lagrangian-and-hamiltonian-mechanics/python/energy_drift_comparison.py
    python articles/lagrangian-and-hamiltonian-mechanics/python/poisson_bracket_scaffold.py
    python articles/lagrangian-and-hamiltonian-mechanics/python/normal_modes_scaffold.py

## R

From the repository root:

    Rscript articles/lagrangian-and-hamiltonian-mechanics/r/pendulum_phase_space_summary.R
    Rscript articles/lagrangian-and-hamiltonian-mechanics/r/hamiltonian_energy_grid.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/lagrangian-and-hamiltonian-mechanics/julia/hamiltonian_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/lagrangian-and-hamiltonian-mechanics/cpp/symplectic_pendulum.cpp -o symplectic_pendulum
    ./symplectic_pendulum

## Fortran

Compile and run:

    gfortran articles/lagrangian-and-hamiltonian-mechanics/fortran/hamiltonian_table.f90 -o hamiltonian_table
    ./hamiltonian_table

## SQL

Run with SQLite:

    sqlite3 articles/lagrangian-and-hamiltonian-mechanics/data/analytical_mechanics.sqlite < articles/lagrangian-and-hamiltonian-mechanics/sql/analytical_mechanics_schema.sql

## Rust

Compile and run:

    rustc articles/lagrangian-and-hamiltonian-mechanics/rust/hamiltonian_pendulum_cli.rs -o hamiltonian_pendulum_cli
    ./hamiltonian_pendulum_cli

## C

Compile and run:

    gcc articles/lagrangian-and-hamiltonian-mechanics/c/hamiltonian_table.c -o hamiltonian_table_c -lm
    ./hamiltonian_table_c
