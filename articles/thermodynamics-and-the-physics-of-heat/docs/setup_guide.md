# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/thermodynamics-and-the-physics-of-heat/python/process_paths.py
    python articles/thermodynamics-and-the-physics-of-heat/python/carnot_efficiency_surface.py
    python articles/thermodynamics-and-the-physics-of-heat/python/free_energy_surface.py

## R

From the repository root:

    Rscript articles/thermodynamics-and-the-physics-of-heat/r/isothermal_entropy_accounting.R
    Rscript articles/thermodynamics-and-the-physics-of-heat/r/thermal_measurement_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/thermodynamics-and-the-physics-of-heat/julia/reversible_cycle_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/thermodynamics-and-the-physics-of-heat/cpp/heat_engine_parameter_sweep.cpp -o heat_engine_parameter_sweep
    ./heat_engine_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/thermodynamics-and-the-physics-of-heat/fortran/ideal_gas_process_table.f90 -o ideal_gas_process_table
    ./ideal_gas_process_table

## SQL

Run with SQLite:

    sqlite3 articles/thermodynamics-and-the-physics-of-heat/data/thermodynamics.sqlite < articles/thermodynamics-and-the-physics-of-heat/sql/thermodynamics_schema.sql

## Rust

Compile and run:

    rustc articles/thermodynamics-and-the-physics-of-heat/rust/thermodynamics_cli.rs -o thermodynamics_cli
    ./thermodynamics_cli

## C

Compile and run:

    gcc articles/thermodynamics-and-the-physics-of-heat/c/ideal_gas_work_entropy.c -o ideal_gas_work_entropy_c -lm
    ./ideal_gas_work_entropy_c
