# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/continuum-physics-and-material-behavior/python/stress_tensor_diagnostics.py
    python articles/continuum-physics-and-material-behavior/python/beam_deflection_scaffold.py
    python articles/continuum-physics-and-material-behavior/python/viscoelastic_response_scaffold.py

## R

From the repository root:

    Rscript articles/continuum-physics-and-material-behavior/r/stress_strain_modulus_estimation.R
    Rscript articles/continuum-physics-and-material-behavior/r/material_property_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/continuum-physics-and-material-behavior/julia/material_response_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/continuum-physics-and-material-behavior/cpp/yield_criterion_sweep.cpp -o yield_criterion_sweep
    ./yield_criterion_sweep

## Fortran

Compile and run:

    gfortran articles/continuum-physics-and-material-behavior/fortran/stress_strain_table.f90 -o stress_strain_table
    ./stress_strain_table

## SQL

Run with SQLite:

    sqlite3 articles/continuum-physics-and-material-behavior/data/continuum_materials.sqlite < articles/continuum-physics-and-material-behavior/sql/continuum_materials_schema.sql

## Rust

Compile and run:

    rustc articles/continuum-physics-and-material-behavior/rust/material_behavior_cli.rs -o material_behavior_cli
    ./material_behavior_cli

## C

Compile and run:

    gcc articles/continuum-physics-and-material-behavior/c/stress_strain_table.c -o stress_strain_table_c -lm
    ./stress_strain_table_c
