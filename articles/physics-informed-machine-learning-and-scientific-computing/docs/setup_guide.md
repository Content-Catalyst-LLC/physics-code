# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib torch
    python articles/physics-informed-machine-learning-and-scientific-computing/python/pinn_decay_equation.py
    python articles/physics-informed-machine-learning-and-scientific-computing/python/heat_equation_residual_diagnostics.py
    python articles/physics-informed-machine-learning-and-scientific-computing/python/inverse_diffusion_parameter.py
    python articles/physics-informed-machine-learning-and-scientific-computing/python/operator_learning_dataset.py
    python articles/physics-informed-machine-learning-and-scientific-computing/python/conservation_diagnostics.py

## R

From the repository root:

    Rscript articles/physics-informed-machine-learning-and-scientific-computing/r/heat_equation_residual_diagnostics.R
    Rscript articles/physics-informed-machine-learning-and-scientific-computing/r/sciml_audit_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/physics-informed-machine-learning-and-scientific-computing/julia/sciml_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/physics-informed-machine-learning-and-scientific-computing/cpp/residual_sweep.cpp -o residual_sweep
    ./residual_sweep

## Fortran

Compile and run:

    gfortran articles/physics-informed-machine-learning-and-scientific-computing/fortran/heat_residual_table.f90 -o heat_residual_table
    ./heat_residual_table

## SQL

Run with SQLite:

    sqlite3 articles/physics-informed-machine-learning-and-scientific-computing/data/sciml.sqlite < articles/physics-informed-machine-learning-and-scientific-computing/sql/sciml_schema.sql

## Rust

Compile and run:

    rustc articles/physics-informed-machine-learning-and-scientific-computing/rust/sciml_cli.rs -o sciml_cli
    ./sciml_cli

## C

Compile and run:

    gcc articles/physics-informed-machine-learning-and-scientific-computing/c/heat_residual.c -o heat_residual_c -lm
    ./heat_residual_c
