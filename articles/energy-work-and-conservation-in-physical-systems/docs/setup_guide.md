# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/energy-work-and-conservation-in-physical-systems/python/spring_energy_simulation.py
    python articles/energy-work-and-conservation-in-physical-systems/python/work_energy_theorem_check.py
    python articles/energy-work-and-conservation-in-physical-systems/python/energy_landscape_accessible_motion.py

## R

From the repository root:

    Rscript articles/energy-work-and-conservation-in-physical-systems/r/spring_mass_energy_accounting.R
    Rscript articles/energy-work-and-conservation-in-physical-systems/r/experimental_energy_residuals.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/energy-work-and-conservation-in-physical-systems/julia/energy_landscape_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/energy-work-and-conservation-in-physical-systems/cpp/work_energy_parameter_sweep.cpp -o work_energy_parameter_sweep
    ./work_energy_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/energy-work-and-conservation-in-physical-systems/fortran/spring_energy_table.f90 -o spring_energy_table
    ./spring_energy_table

## SQL

Run with SQLite:

    sqlite3 articles/energy-work-and-conservation-in-physical-systems/data/energy_work_conservation.sqlite < articles/energy-work-and-conservation-in-physical-systems/sql/energy_work_conservation_schema.sql

## Rust

Compile and run:

    rustc articles/energy-work-and-conservation-in-physical-systems/rust/energy_work_cli.rs -o energy_work_cli
    ./energy_work_cli

## C

Compile and run:

    gcc articles/energy-work-and-conservation-in-physical-systems/c/spring_energy_table.c -o spring_energy_table_c -lm
    ./spring_energy_table_c
