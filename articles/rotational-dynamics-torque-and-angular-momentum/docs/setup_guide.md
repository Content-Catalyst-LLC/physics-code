# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/rotational-dynamics-torque-and-angular-momentum/python/torque_driven_rotation.py
    python articles/rotational-dynamics-torque-and-angular-momentum/python/rolling_body_comparison.py
    python articles/rotational-dynamics-torque-and-angular-momentum/python/gyroscope_precession_scaffold.py

## R

From the repository root:

    Rscript articles/rotational-dynamics-torque-and-angular-momentum/r/rolling_energy_partition.R
    Rscript articles/rotational-dynamics-torque-and-angular-momentum/r/moment_of_inertia_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/rotational-dynamics-torque-and-angular-momentum/julia/rotational_dynamics_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/rotational-dynamics-torque-and-angular-momentum/cpp/rolling_parameter_sweep.cpp -o rolling_parameter_sweep
    ./rolling_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/rotational-dynamics-torque-and-angular-momentum/fortran/moment_of_inertia_table.f90 -o moment_of_inertia_table
    ./moment_of_inertia_table

## SQL

Run with SQLite:

    sqlite3 articles/rotational-dynamics-torque-and-angular-momentum/data/rotational_dynamics.sqlite < articles/rotational-dynamics-torque-and-angular-momentum/sql/rotational_dynamics_schema.sql

## Rust

Compile and run:

    rustc articles/rotational-dynamics-torque-and-angular-momentum/rust/rolling_body_cli.rs -o rolling_body_cli
    ./rolling_body_cli

## C

Compile and run:

    gcc articles/rotational-dynamics-torque-and-angular-momentum/c/rolling_body_table.c -o rolling_body_table_c -lm
    ./rolling_body_table_c
