# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/motion-force-and-the-foundations-of-classical-mechanics/python/projectile_motion_models.py
    python articles/motion-force-and-the-foundations-of-classical-mechanics/python/impulse_momentum_analysis.py
    python articles/motion-force-and-the-foundations-of-classical-mechanics/python/newton_force_parameter_sweep.py

## R

From the repository root:

    Rscript articles/motion-force-and-the-foundations-of-classical-mechanics/r/projectile_trajectory_fit.R
    Rscript articles/motion-force-and-the-foundations-of-classical-mechanics/r/trajectory_measurement_residuals.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/motion-force-and-the-foundations-of-classical-mechanics/julia/projectile_force_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/motion-force-and-the-foundations-of-classical-mechanics/cpp/projectile_parameter_sweep.cpp -o projectile_parameter_sweep
    ./projectile_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/motion-force-and-the-foundations-of-classical-mechanics/fortran/kinematics_table.f90 -o kinematics_table
    ./kinematics_table

## SQL

Run with SQLite:

    sqlite3 articles/motion-force-and-the-foundations-of-classical-mechanics/data/classical_mechanics.sqlite < articles/motion-force-and-the-foundations-of-classical-mechanics/sql/classical_mechanics_schema.sql

## Rust

Compile and run:

    rustc articles/motion-force-and-the-foundations-of-classical-mechanics/rust/classical_mechanics_cli.rs -o classical_mechanics_cli
    ./classical_mechanics_cli

## C

Compile and run:

    gcc articles/motion-force-and-the-foundations-of-classical-mechanics/c/projectile_table.c -o projectile_table_c -lm
    ./projectile_table_c
