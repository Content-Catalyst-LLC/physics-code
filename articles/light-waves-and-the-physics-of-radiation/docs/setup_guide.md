# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/light-waves-and-the-physics-of-radiation/python/interference_planck_radiation.py
    python articles/light-waves-and-the-physics-of-radiation/python/diffraction_envelope.py
    python articles/light-waves-and-the-physics-of-radiation/python/spectral_band_summary.py

## R

From the repository root:

    Rscript articles/light-waves-and-the-physics-of-radiation/r/blackbody_interference_summary.R
    Rscript articles/light-waves-and-the-physics-of-radiation/r/radiation_law_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/light-waves-and-the-physics-of-radiation/julia/spectral_radiance_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/light-waves-and-the-physics-of-radiation/cpp/radiation_parameter_sweep.cpp -o radiation_parameter_sweep
    ./radiation_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/light-waves-and-the-physics-of-radiation/fortran/wave_relation_table.f90 -o wave_relation_table
    ./wave_relation_table

## SQL

Run with SQLite:

    sqlite3 articles/light-waves-and-the-physics-of-radiation/data/light_waves_radiation.sqlite < articles/light-waves-and-the-physics-of-radiation/sql/light_waves_radiation_schema.sql

## Rust

Compile and run:

    rustc articles/light-waves-and-the-physics-of-radiation/rust/wave_energy_cli.rs -o wave_energy_cli
    ./wave_energy_cli

## C

Compile and run:

    gcc articles/light-waves-and-the-physics-of-radiation/c/planck_law_table.c -o planck_law_table_c -lm
    ./planck_law_table_c
