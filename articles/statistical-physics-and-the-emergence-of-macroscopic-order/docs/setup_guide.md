# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/statistical-physics-and-the-emergence-of-macroscopic-order/python/two_state_distribution.py
    python articles/statistical-physics-and-the-emergence-of-macroscopic-order/python/partition_function_summary.py
    python articles/statistical-physics-and-the-emergence-of-macroscopic-order/python/ising_lattice_scaffold.py

## R

From the repository root:

    Rscript articles/statistical-physics-and-the-emergence-of-macroscopic-order/r/two_state_fluctuation_scaling.R
    Rscript articles/statistical-physics-and-the-emergence-of-macroscopic-order/r/ensemble_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/statistical-physics-and-the-emergence-of-macroscopic-order/julia/ising_lattice_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/statistical-physics-and-the-emergence-of-macroscopic-order/cpp/two_state_parameter_sweep.cpp -o two_state_parameter_sweep
    ./two_state_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/statistical-physics-and-the-emergence-of-macroscopic-order/fortran/two_state_partition_table.f90 -o two_state_partition_table
    ./two_state_partition_table

## SQL

Run with SQLite:

    sqlite3 articles/statistical-physics-and-the-emergence-of-macroscopic-order/data/statistical_physics.sqlite < articles/statistical-physics-and-the-emergence-of-macroscopic-order/sql/statistical_physics_schema.sql

## Rust

Compile and run:

    rustc articles/statistical-physics-and-the-emergence-of-macroscopic-order/rust/two_state_cli.rs -o two_state_cli
    ./two_state_cli

## C

Compile and run:

    gcc articles/statistical-physics-and-the-emergence-of-macroscopic-order/c/two_state_partition_table.c -o two_state_partition_table_c -lm
    ./two_state_partition_table_c
