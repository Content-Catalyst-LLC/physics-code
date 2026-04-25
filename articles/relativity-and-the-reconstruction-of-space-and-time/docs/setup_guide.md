# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/relativity-and-the-reconstruction-of-space-and-time/python/lorentz_transform_intervals.py
    python articles/relativity-and-the-reconstruction-of-space-and-time/python/velocity_composition_rapidity.py
    python articles/relativity-and-the-reconstruction-of-space-and-time/python/relativistic_doppler_shift.py

## R

From the repository root:

    Rscript articles/relativity-and-the-reconstruction-of-space-and-time/r/lorentz_factor_energy_scaling.R
    Rscript articles/relativity-and-the-reconstruction-of-space-and-time/r/relativity_model_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/relativity-and-the-reconstruction-of-space-and-time/julia/rapidity_boosts.jl

## C++

Compile and run:

    g++ -std=c++17 articles/relativity-and-the-reconstruction-of-space-and-time/cpp/relativistic_parameter_sweep.cpp -o relativistic_parameter_sweep
    ./relativistic_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/relativity-and-the-reconstruction-of-space-and-time/fortran/lorentz_factor_table.f90 -o lorentz_factor_table
    ./lorentz_factor_table

## SQL

Run with SQLite:

    sqlite3 articles/relativity-and-the-reconstruction-of-space-and-time/data/relativity.sqlite < articles/relativity-and-the-reconstruction-of-space-and-time/sql/relativity_schema.sql

## Rust

Compile and run:

    rustc articles/relativity-and-the-reconstruction-of-space-and-time/rust/relativity_cli.rs -o relativity_cli
    ./relativity_cli

## C

Compile and run:

    gcc articles/relativity-and-the-reconstruction-of-space-and-time/c/lorentz_factor_table.c -o lorentz_factor_table_c -lm
    ./lorentz_factor_table_c
