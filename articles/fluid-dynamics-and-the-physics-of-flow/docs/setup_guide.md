# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/fluid-dynamics-and-the-physics-of-flow/python/vorticity_field_diagnostics.py
    python articles/fluid-dynamics-and-the-physics-of-flow/python/bernoulli_pipe_scaffold.py
    python articles/fluid-dynamics-and-the-physics-of-flow/python/advection_diffusion_scaffold.py

## R

From the repository root:

    Rscript articles/fluid-dynamics-and-the-physics-of-flow/r/reynolds_number_classification.R
    Rscript articles/fluid-dynamics-and-the-physics-of-flow/r/fluid_properties_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/fluid-dynamics-and-the-physics-of-flow/julia/fluid_flow_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/fluid-dynamics-and-the-physics-of-flow/cpp/reynolds_parameter_sweep.cpp -o reynolds_parameter_sweep
    ./reynolds_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/fluid-dynamics-and-the-physics-of-flow/fortran/flow_regime_table.f90 -o flow_regime_table
    ./flow_regime_table

## SQL

Run with SQLite:

    sqlite3 articles/fluid-dynamics-and-the-physics-of-flow/data/fluid_dynamics.sqlite < articles/fluid-dynamics-and-the-physics-of-flow/sql/fluid_dynamics_schema.sql

## Rust

Compile and run:

    rustc articles/fluid-dynamics-and-the-physics-of-flow/rust/fluid_flow_cli.rs -o fluid_flow_cli
    ./fluid_flow_cli

## C

Compile and run:

    gcc articles/fluid-dynamics-and-the-physics-of-flow/c/reynolds_table.c -o reynolds_table_c -lm
    ./reynolds_table_c
