# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib sympy
    python articles/mathematical-methods-in-physics/python/ode_eigen_fourier_workflow.py
    python articles/mathematical-methods-in-physics/python/dimensional_analysis_scaffold.py
    python articles/mathematical-methods-in-physics/python/tensor_operations_scaffold.py
    python articles/mathematical-methods-in-physics/python/pde_grid_scaffold.py

## R

From the repository root:

    Rscript articles/mathematical-methods-in-physics/r/uncertainty_propagation.R
    Rscript articles/mathematical-methods-in-physics/r/dimensional_consistency_table.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/mathematical-methods-in-physics/julia/numerical_methods_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/mathematical-methods-in-physics/cpp/finite_difference_oscillator.cpp -o finite_difference_oscillator
    ./finite_difference_oscillator

## Fortran

Compile and run:

    gfortran articles/mathematical-methods-in-physics/fortran/numerical_methods_table.f90 -o numerical_methods_table
    ./numerical_methods_table

## SQL

Run with SQLite:

    sqlite3 articles/mathematical-methods-in-physics/data/mathematical_methods.sqlite < articles/mathematical-methods-in-physics/sql/mathematical_methods_schema.sql

## Rust

Compile and run:

    rustc articles/mathematical-methods-in-physics/rust/math_methods_cli.rs -o math_methods_cli
    ./math_methods_cli

## C

Compile and run:

    gcc articles/mathematical-methods-in-physics/c/oscillator_table.c -o oscillator_table_c -lm
    ./oscillator_table_c
