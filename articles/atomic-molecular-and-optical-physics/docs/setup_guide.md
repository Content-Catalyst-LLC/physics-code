# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/atomic-molecular-and-optical-physics/python/hydrogen_spectral_lines.py
    python articles/atomic-molecular-and-optical-physics/python/two_level_rabi_oscillations.py
    python articles/atomic-molecular-and-optical-physics/python/molecular_rotational_spectrum.py
    python articles/atomic-molecular-and-optical-physics/python/spectral_line_fit_scaffold.py

## R

From the repository root:

    Rscript articles/atomic-molecular-and-optical-physics/r/rotational_boltzmann_populations.R
    Rscript articles/atomic-molecular-and-optical-physics/r/spectral_transition_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/atomic-molecular-and-optical-physics/julia/amo_spectrum_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/atomic-molecular-and-optical-physics/cpp/rydberg_spectral_sweep.cpp -o rydberg_spectral_sweep
    ./rydberg_spectral_sweep

## Fortran

Compile and run:

    gfortran articles/atomic-molecular-and-optical-physics/fortran/hydrogen_transition_table.f90 -o hydrogen_transition_table
    ./hydrogen_transition_table

## SQL

Run with SQLite:

    sqlite3 articles/atomic-molecular-and-optical-physics/data/amo_physics.sqlite < articles/atomic-molecular-and-optical-physics/sql/amo_physics_schema.sql

## Rust

Compile and run:

    rustc articles/atomic-molecular-and-optical-physics/rust/photon_transition_cli.rs -o photon_transition_cli
    ./photon_transition_cli

## C

Compile and run:

    gcc articles/atomic-molecular-and-optical-physics/c/hydrogen_spectrum_table.c -o hydrogen_spectrum_table_c -lm
    ./hydrogen_spectrum_table_c
