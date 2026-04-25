# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/gravity-curvature-and-the-structure-of-spacetime/python/schwarzschild_time_dilation.py
    python articles/gravity-curvature-and-the-structure-of-spacetime/python/weak_field_comparison.py
    python articles/gravity-curvature-and-the-structure-of-spacetime/python/gravitational_wave_strain_toy_model.py

## R

From the repository root:

    Rscript articles/gravity-curvature-and-the-structure-of-spacetime/r/time_dilation_radius_sweep.R
    Rscript articles/gravity-curvature-and-the-structure-of-spacetime/r/spacetime_model_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/gravity-curvature-and-the-structure-of-spacetime/julia/schwarzschild_effective_potential.jl

## C++

Compile and run:

    g++ -std=c++17 articles/gravity-curvature-and-the-structure-of-spacetime/cpp/schwarzschild_parameter_sweep.cpp -o schwarzschild_parameter_sweep
    ./schwarzschild_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/gravity-curvature-and-the-structure-of-spacetime/fortran/schwarzschild_radius_table.f90 -o schwarzschild_radius_table
    ./schwarzschild_radius_table

## SQL

Run with SQLite:

    sqlite3 articles/gravity-curvature-and-the-structure-of-spacetime/data/spacetime_gravity.sqlite < articles/gravity-curvature-and-the-structure-of-spacetime/sql/spacetime_gravity_schema.sql

## Rust

Compile and run:

    rustc articles/gravity-curvature-and-the-structure-of-spacetime/rust/schwarzschild_cli.rs -o schwarzschild_cli
    ./schwarzschild_cli

## C

Compile and run:

    gcc articles/gravity-curvature-and-the-structure-of-spacetime/c/schwarzschild_time_dilation.c -o schwarzschild_time_dilation_c -lm
    ./schwarzschild_time_dilation_c
