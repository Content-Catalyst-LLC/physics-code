# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/phase-transitions-critical-phenomena-and-the-renormalization-group/python/ising_2d_monte_carlo.py
    python articles/phase-transitions-critical-phenomena-and-the-renormalization-group/python/binder_cumulant.py
    python articles/phase-transitions-critical-phenomena-and-the-renormalization-group/python/finite_size_scaling.py
    python articles/phase-transitions-critical-phenomena-and-the-renormalization-group/python/correlation_function.py
    python articles/phase-transitions-critical-phenomena-and-the-renormalization-group/python/rg_toy_flow.py

## R

From the repository root:

    Rscript articles/phase-transitions-critical-phenomena-and-the-renormalization-group/r/landau_free_energy.R
    Rscript articles/phase-transitions-critical-phenomena-and-the-renormalization-group/r/critical_scaling_tables.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/phase-transitions-critical-phenomena-and-the-renormalization-group/julia/critical_phenomena_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/phase-transitions-critical-phenomena-and-the-renormalization-group/cpp/ising_temperature_sweep.cpp -o ising_temperature_sweep
    ./ising_temperature_sweep

## Fortran

Compile and run:

    gfortran articles/phase-transitions-critical-phenomena-and-the-renormalization-group/fortran/landau_finite_size_table.f90 -o landau_finite_size_table
    ./landau_finite_size_table

## SQL

Run with SQLite:

    sqlite3 articles/phase-transitions-critical-phenomena-and-the-renormalization-group/data/critical_phenomena.sqlite < articles/phase-transitions-critical-phenomena-and-the-renormalization-group/sql/critical_phenomena_schema.sql

## Rust

Compile and run:

    rustc articles/phase-transitions-critical-phenomena-and-the-renormalization-group/rust/critical_cli.rs -o critical_cli
    ./critical_cli

## C

Compile and run:

    gcc articles/phase-transitions-critical-phenomena-and-the-renormalization-group/c/landau_scaling_table.c -o landau_scaling_table_c -lm
    ./landau_scaling_table_c
