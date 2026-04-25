# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/climate-physics-and-planetary-energy-balance/python/one_layer_energy_balance_model.py
    python articles/climate-physics-and-planetary-energy-balance/python/two_layer_ocean_heat_uptake.py
    python articles/climate-physics-and-planetary-energy-balance/python/albedo_sensitivity.py
    python articles/climate-physics-and-planetary-energy-balance/python/climate_uncertainty_monte_carlo.py

## R

From the repository root:

    Rscript articles/climate-physics-and-planetary-energy-balance/r/zero_dimensional_energy_balance.R
    Rscript articles/climate-physics-and-planetary-energy-balance/r/equilibrium_warming_sensitivity.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/climate-physics-and-planetary-energy-balance/julia/climate_response_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/climate-physics-and-planetary-energy-balance/cpp/energy_balance_parameter_sweep.cpp -o energy_balance_parameter_sweep
    ./energy_balance_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/climate-physics-and-planetary-energy-balance/fortran/radiation_balance_table.f90 -o radiation_balance_table
    ./radiation_balance_table

## SQL

Run with SQLite:

    sqlite3 articles/climate-physics-and-planetary-energy-balance/data/climate_physics.sqlite < articles/climate-physics-and-planetary-energy-balance/sql/climate_physics_schema.sql

## Rust

Compile and run:

    rustc articles/climate-physics-and-planetary-energy-balance/rust/climate_balance_cli.rs -o climate_balance_cli
    ./climate_balance_cli

## C

Compile and run:

    gcc articles/climate-physics-and-planetary-energy-balance/c/energy_balance_table.c -o energy_balance_table_c -lm
    ./energy_balance_table_c
