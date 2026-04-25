# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/nonlinear-dynamics-chaos-and-complex-physical-systems/python/lorenz_trajectory_separation.py
    python articles/nonlinear-dynamics-chaos-and-complex-physical-systems/python/logistic_map_bifurcation.py
    python articles/nonlinear-dynamics-chaos-and-complex-physical-systems/python/fixed_point_stability.py
    python articles/nonlinear-dynamics-chaos-and-complex-physical-systems/python/lyapunov_logistic_scaffold.py

## R

From the repository root:

    Rscript articles/nonlinear-dynamics-chaos-and-complex-physical-systems/r/logistic_map_bifurcation_summary.R
    Rscript articles/nonlinear-dynamics-chaos-and-complex-physical-systems/r/parameter_sweep_diagnostics.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/nonlinear-dynamics-chaos-and-complex-physical-systems/julia/nonlinear_dynamics_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/nonlinear-dynamics-chaos-and-complex-physical-systems/cpp/logistic_map_sweep.cpp -o logistic_map_sweep
    ./logistic_map_sweep

## Fortran

Compile and run:

    gfortran articles/nonlinear-dynamics-chaos-and-complex-physical-systems/fortran/lorenz_table.f90 -o lorenz_table
    ./lorenz_table

## SQL

Run with SQLite:

    sqlite3 articles/nonlinear-dynamics-chaos-and-complex-physical-systems/data/nonlinear_dynamics.sqlite < articles/nonlinear-dynamics-chaos-and-complex-physical-systems/sql/nonlinear_dynamics_schema.sql

## Rust

Compile and run:

    rustc articles/nonlinear-dynamics-chaos-and-complex-physical-systems/rust/logistic_map_cli.rs -o logistic_map_cli
    ./logistic_map_cli

## C

Compile and run:

    gcc articles/nonlinear-dynamics-chaos-and-complex-physical-systems/c/logistic_map_table.c -o logistic_map_table_c -lm
    ./logistic_map_table_c
