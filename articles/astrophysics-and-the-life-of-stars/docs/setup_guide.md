# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas matplotlib scipy
    python articles/astrophysics-and-the-life-of-stars/python/stellar_mass_luminosity_lifetime.py
    python articles/astrophysics-and-the-life-of-stars/python/hr_radius_temperature_scaling.py

## R

From the repository root:

    Rscript articles/astrophysics-and-the-life-of-stars/r/hr_diagram_scaling_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/astrophysics-and-the-life-of-stars/julia/hydrostatic_equilibrium_toy_model.jl

## C++

Compile and run:

    g++ -std=c++17 articles/astrophysics-and-the-life-of-stars/cpp/stellar_parameter_sweep.cpp -o stellar_parameter_sweep
    ./stellar_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/astrophysics-and-the-life-of-stars/fortran/stellar_scaling_table.f90 -o stellar_scaling_table
    ./stellar_scaling_table

## SQL

Run with SQLite:

    sqlite3 articles/astrophysics-and-the-life-of-stars/data/stellar_astrophysics.sqlite < articles/astrophysics-and-the-life-of-stars/sql/stellar_astrophysics_schema.sql

## Rust

Compile and run:

    rustc articles/astrophysics-and-the-life-of-stars/rust/stellar_scaling_cli.rs -o stellar_scaling_cli
    ./stellar_scaling_cli

## C

Compile and run:

    gcc articles/astrophysics-and-the-life-of-stars/c/stellar_scaling_table.c -o stellar_scaling_table_c -lm
    ./stellar_scaling_table_c
