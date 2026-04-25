# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/symmetry-law-and-the-search-for-physical-order/python/noether_energy_conservation.py
    python articles/symmetry-law-and-the-search-for-physical-order/python/symmetry_breaking_potential_scan.py
    python articles/symmetry-law-and-the-search-for-physical-order/python/gauge_phase_invariance_demo.py

## R

From the repository root:

    Rscript articles/symmetry-law-and-the-search-for-physical-order/r/reflection_symmetry_summary.R
    Rscript articles/symmetry-law-and-the-search-for-physical-order/r/symmetry_breaking_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/symmetry-law-and-the-search-for-physical-order/julia/noether_energy_check.jl

## C++

Compile and run:

    g++ -std=c++17 articles/symmetry-law-and-the-search-for-physical-order/cpp/potential_parameter_sweep.cpp -o potential_parameter_sweep
    ./potential_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/symmetry-law-and-the-search-for-physical-order/fortran/conservation_table.f90 -o conservation_table
    ./conservation_table

## SQL

Run with SQLite:

    sqlite3 articles/symmetry-law-and-the-search-for-physical-order/data/symmetry_physics.sqlite < articles/symmetry-law-and-the-search-for-physical-order/sql/symmetry_physics_schema.sql

## Rust

Compile and run:

    rustc articles/symmetry-law-and-the-search-for-physical-order/rust/double_well_minima_cli.rs -o double_well_minima_cli
    ./double_well_minima_cli

## C

Compile and run:

    gcc articles/symmetry-law-and-the-search-for-physical-order/c/harmonic_energy_check.c -o harmonic_energy_check -lm
    ./harmonic_energy_check
