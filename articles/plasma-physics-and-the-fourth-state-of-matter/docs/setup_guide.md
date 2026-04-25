# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/plasma-physics-and-the-fourth-state-of-matter/python/charged_particle_gyration.py
    python articles/plasma-physics-and-the-fourth-state-of-matter/python/plasma_parameter_sweep.py
    python articles/plasma-physics-and-the-fourth-state-of-matter/python/debye_plasma_frequency.py
    python articles/plasma-physics-and-the-fourth-state-of-matter/python/alfven_beta_diagnostics.py

## R

From the repository root:

    Rscript articles/plasma-physics-and-the-fourth-state-of-matter/r/plasma_parameter_sensitivity.R
    Rscript articles/plasma-physics-and-the-fourth-state-of-matter/r/debye_sphere_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/plasma-physics-and-the-fourth-state-of-matter/julia/plasma_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/plasma-physics-and-the-fourth-state-of-matter/cpp/plasma_parameter_sweep.cpp -o plasma_parameter_sweep
    ./plasma_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/plasma-physics-and-the-fourth-state-of-matter/fortran/plasma_frequency_table.f90 -o plasma_frequency_table
    ./plasma_frequency_table

## SQL

Run with SQLite:

    sqlite3 articles/plasma-physics-and-the-fourth-state-of-matter/data/plasma_physics.sqlite < articles/plasma-physics-and-the-fourth-state-of-matter/sql/plasma_physics_schema.sql

## Rust

Compile and run:

    rustc articles/plasma-physics-and-the-fourth-state-of-matter/rust/plasma_cli.rs -o plasma_cli
    ./plasma_cli

## C

Compile and run:

    gcc articles/plasma-physics-and-the-fourth-state-of-matter/c/debye_frequency_table.c -o debye_frequency_table_c -lm
    ./debye_frequency_table_c
