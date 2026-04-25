# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy sympy matplotlib
    python articles/quantum-field-theory-i-fields-particles-and-second-quantization/python/fock_ladder_operators.py
    python articles/quantum-field-theory-i-fields-particles-and-second-quantization/python/scalar_field_modes.py
    python articles/quantum-field-theory-i-fields-particles-and-second-quantization/python/propagator_grid.py
    python articles/quantum-field-theory-i-fields-particles-and-second-quantization/python/fermionic_anticommutation.py
    python articles/quantum-field-theory-i-fields-particles-and-second-quantization/python/wick_contraction_metadata.py

## R

From the repository root:

    Rscript articles/quantum-field-theory-i-fields-particles-and-second-quantization/r/bose_mode_occupation.R
    Rscript articles/quantum-field-theory-i-fields-particles-and-second-quantization/r/fock_state_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/quantum-field-theory-i-fields-particles-and-second-quantization/julia/qft_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/quantum-field-theory-i-fields-particles-and-second-quantization/cpp/fock_space_sweep.cpp -o fock_space_sweep
    ./fock_space_sweep

## Fortran

Compile and run:

    gfortran articles/quantum-field-theory-i-fields-particles-and-second-quantization/fortran/mode_occupation_table.f90 -o mode_occupation_table
    ./mode_occupation_table

## SQL

Run with SQLite:

    sqlite3 articles/quantum-field-theory-i-fields-particles-and-second-quantization/data/qft_second_quantization.sqlite < articles/quantum-field-theory-i-fields-particles-and-second-quantization/sql/qft_second_quantization_schema.sql

## Rust

Compile and run:

    rustc articles/quantum-field-theory-i-fields-particles-and-second-quantization/rust/qft_cli.rs -o qft_cli
    ./qft_cli

## C

Compile and run:

    gcc articles/quantum-field-theory-i-fields-particles-and-second-quantization/c/oscillator_occupation_table.c -o oscillator_occupation_table_c -lm
    ./oscillator_occupation_table_c
