# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/electromagnetism-and-the-unification-of-fields/python/potential_field_superposition.py
    python articles/electromagnetism-and-the-unification-of-fields/python/laplace_boundary_solver.py
    python articles/electromagnetism-and-the-unification-of-fields/python/maxwell_wave_relations.py

## R

From the repository root:

    Rscript articles/electromagnetism-and-the-unification-of-fields/r/point_charge_wire_fields.R
    Rscript articles/electromagnetism-and-the-unification-of-fields/r/material_property_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/electromagnetism-and-the-unification-of-fields/julia/laplace_solver_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/electromagnetism-and-the-unification-of-fields/cpp/electromagnetic_parameter_sweep.cpp -o electromagnetic_parameter_sweep
    ./electromagnetic_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/electromagnetism-and-the-unification-of-fields/fortran/electric_field_table.f90 -o electric_field_table
    ./electric_field_table

## SQL

Run with SQLite:

    sqlite3 articles/electromagnetism-and-the-unification-of-fields/data/electromagnetism.sqlite < articles/electromagnetism-and-the-unification-of-fields/sql/electromagnetism_schema.sql

## Rust

Compile and run:

    rustc articles/electromagnetism-and-the-unification-of-fields/rust/electromagnetism_cli.rs -o electromagnetism_cli
    ./electromagnetism_cli

## C

Compile and run:

    gcc articles/electromagnetism-and-the-unification-of-fields/c/coulomb_field_table.c -o coulomb_field_table_c -lm
    ./coulomb_field_table_c
