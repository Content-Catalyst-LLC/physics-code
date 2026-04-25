# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/python/decay_binding_energy.py
    python articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/python/semi_empirical_mass_formula.py

## R

From the repository root:

    Rscript articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/r/half_life_decay_fit.R
    Rscript articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/r/isotope_summary.R

Required R packages:

    install.packages(c("tidyverse", "broom"))

## Julia

Run:

    julia articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/julia/isotope_binding_decay_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/cpp/binding_energy_parameter_sweep.cpp -o binding_energy_parameter_sweep
    ./binding_energy_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/fortran/radioactive_decay_table.f90 -o radioactive_decay_table
    ./radioactive_decay_table

## SQL

Run with SQLite:

    sqlite3 articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/data/nuclear_physics.sqlite < articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/sql/nuclear_physics_schema.sql

## Rust

Compile and run:

    rustc articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/rust/half_life_cli.rs -o half_life_cli
    ./half_life_cli

## C

Compile and run:

    gcc articles/nuclear-physics-and-the-energetics-of-the-atomic-nucleus/c/helium4_binding_energy.c -o helium4_binding_energy -lm
    ./helium4_binding_energy
