# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/gravitation-orbits-and-celestial-mechanics/python/two_body_orbit_integration.py
    python articles/gravitation-orbits-and-celestial-mechanics/python/orbital_energy_diagnostics.py
    python articles/gravitation-orbits-and-celestial-mechanics/python/hohmann_transfer_scaffold.py

## R

From the repository root:

    Rscript articles/gravitation-orbits-and-celestial-mechanics/r/circular_orbit_scaling.R
    Rscript articles/gravitation-orbits-and-celestial-mechanics/r/kepler_period_law_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/gravitation-orbits-and-celestial-mechanics/julia/orbit_transfer_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/gravitation-orbits-and-celestial-mechanics/cpp/orbit_parameter_sweep.cpp -o orbit_parameter_sweep
    ./orbit_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/gravitation-orbits-and-celestial-mechanics/fortran/orbital_period_table.f90 -o orbital_period_table
    ./orbital_period_table

## SQL

Run with SQLite:

    sqlite3 articles/gravitation-orbits-and-celestial-mechanics/data/celestial_mechanics.sqlite < articles/gravitation-orbits-and-celestial-mechanics/sql/celestial_mechanics_schema.sql

## Rust

Compile and run:

    rustc articles/gravitation-orbits-and-celestial-mechanics/rust/orbit_cli.rs -o orbit_cli
    ./orbit_cli

## C

Compile and run:

    gcc articles/gravitation-orbits-and-celestial-mechanics/c/orbit_speed_table.c -o orbit_speed_table_c -lm
    ./orbit_speed_table_c
