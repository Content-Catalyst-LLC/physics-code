# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas matplotlib scipy
    python articles/cosmology-and-the-history-of-the-universe/python/hubble_scale_factor_tables.py
    python articles/cosmology-and-the-history-of-the-universe/python/lcdm_expansion_history.py

## R

From the repository root:

    Rscript articles/cosmology-and-the-history-of-the-universe/r/redshift_hubble_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/cosmology-and-the-history-of-the-universe/julia/scale_factor_expansion_model.jl

## C++

Compile and run:

    g++ -std=c++17 articles/cosmology-and-the-history-of-the-universe/cpp/hubble_parameter_sweep.cpp -o hubble_parameter_sweep
    ./hubble_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/cosmology-and-the-history-of-the-universe/fortran/radiation_temperature_scaling.f90 -o radiation_temperature_scaling
    ./radiation_temperature_scaling

## SQL

Run with SQLite:

    sqlite3 articles/cosmology-and-the-history-of-the-universe/data/cosmology_metadata.sqlite < articles/cosmology-and-the-history-of-the-universe/sql/cosmology_schema.sql

## Rust

Compile and run:

    rustc articles/cosmology-and-the-history-of-the-universe/rust/redshift_scale_factor_cli.rs -o redshift_scale_factor_cli
    ./redshift_scale_factor_cli

## C

Compile and run:

    gcc articles/cosmology-and-the-history-of-the-universe/c/hubble_velocity_table.c -o hubble_velocity_table
    ./hubble_velocity_table
