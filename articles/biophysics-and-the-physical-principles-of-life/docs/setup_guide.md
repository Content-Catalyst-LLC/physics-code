# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/biophysics-and-the-physical-principles-of-life/python/brownian_motion_msd.py
    python articles/biophysics-and-the-physical-principles-of-life/python/diffusion_timescale_grid.py
    python articles/biophysics-and-the-physical-principles-of-life/python/nernst_potential.py
    python articles/biophysics-and-the-physical-principles-of-life/python/binding_occupancy.py
    python articles/biophysics-and-the-physical-principles-of-life/python/michaelis_menten_kinetics.py
    python articles/biophysics-and-the-physical-principles-of-life/python/molecular_motor_stepping.py

## R

From the repository root:

    Rscript articles/biophysics-and-the-physical-principles-of-life/r/diffusion_timescale_sensitivity.R
    Rscript articles/biophysics-and-the-physical-principles-of-life/r/binding_occupancy_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/biophysics-and-the-physical-principles-of-life/julia/biophysics_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/biophysics-and-the-physical-principles-of-life/cpp/biophysics_parameter_sweep.cpp -o biophysics_parameter_sweep
    ./biophysics_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/biophysics-and-the-physical-principles-of-life/fortran/diffusion_nernst_table.f90 -o diffusion_nernst_table
    ./diffusion_nernst_table

## SQL

Run with SQLite:

    sqlite3 articles/biophysics-and-the-physical-principles-of-life/data/biophysics.sqlite < articles/biophysics-and-the-physical-principles-of-life/sql/biophysics_schema.sql

## Rust

Compile and run:

    rustc articles/biophysics-and-the-physical-principles-of-life/rust/biophysics_cli.rs -o biophysics_cli
    ./biophysics_cli

## C

Compile and run:

    gcc articles/biophysics-and-the-physical-principles-of-life/c/diffusion_binding_table.c -o diffusion_binding_table_c -lm
    ./diffusion_binding_table_c
