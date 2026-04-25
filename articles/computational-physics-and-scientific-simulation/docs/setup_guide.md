# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/computational-physics-and-scientific-simulation/python/diffusion_stability_simulation.py
    python articles/computational-physics-and-scientific-simulation/python/ode_solver_diagnostics.py
    python articles/computational-physics-and-scientific-simulation/python/convergence_diagnostics.py
    python articles/computational-physics-and-scientific-simulation/python/monte_carlo_uncertainty.py

## R

From the repository root:

    Rscript articles/computational-physics-and-scientific-simulation/r/monte_carlo_projectile_uncertainty.R
    Rscript articles/computational-physics-and-scientific-simulation/r/convergence_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/computational-physics-and-scientific-simulation/julia/diffusion_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/computational-physics-and-scientific-simulation/cpp/diffusion_performance_loop.cpp -o diffusion_performance_loop
    ./diffusion_performance_loop

## Fortran

Compile and run:

    gfortran articles/computational-physics-and-scientific-simulation/fortran/diffusion_table.f90 -o diffusion_table
    ./diffusion_table

## SQL

Run with SQLite:

    sqlite3 articles/computational-physics-and-scientific-simulation/data/computational_physics.sqlite < articles/computational-physics-and-scientific-simulation/sql/computational_physics_schema.sql

## Rust

Compile and run:

    rustc articles/computational-physics-and-scientific-simulation/rust/simulation_diagnostics_cli.rs -o simulation_diagnostics_cli
    ./simulation_diagnostics_cli

## C

Compile and run:

    gcc articles/computational-physics-and-scientific-simulation/c/diffusion_table.c -o diffusion_table_c -lm
    ./diffusion_table_c
