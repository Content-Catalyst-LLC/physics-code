# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/quantum-information-decoherence-and-measurement/python/density_matrix_dephasing.py
    python articles/quantum-information-decoherence-and-measurement/python/bloch_vector_diagnostics.py
    python articles/quantum-information-decoherence-and-measurement/python/measurement_born_rule.py
    python articles/quantum-information-decoherence-and-measurement/python/bell_state_entanglement_entropy.py
    python articles/quantum-information-decoherence-and-measurement/python/amplitude_damping_channel.py
    python articles/quantum-information-decoherence-and-measurement/python/three_qubit_bit_flip_code.py

## R

From the repository root:

    Rscript articles/quantum-information-decoherence-and-measurement/r/binary_entropy_measurement_uncertainty.R
    Rscript articles/quantum-information-decoherence-and-measurement/r/decoherence_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/quantum-information-decoherence-and-measurement/julia/qubit_dephasing_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/quantum-information-decoherence-and-measurement/cpp/dephasing_channel_sweep.cpp -o dephasing_channel_sweep
    ./dephasing_channel_sweep

## Fortran

Compile and run:

    gfortran articles/quantum-information-decoherence-and-measurement/fortran/density_matrix_dephasing_table.f90 -o density_matrix_dephasing_table
    ./density_matrix_dephasing_table

## SQL

Run with SQLite:

    sqlite3 articles/quantum-information-decoherence-and-measurement/data/quantum_information.sqlite < articles/quantum-information-decoherence-and-measurement/sql/quantum_information_schema.sql

## Rust

Compile and run:

    rustc articles/quantum-information-decoherence-and-measurement/rust/qubit_dephasing_cli.rs -o qubit_dephasing_cli
    ./qubit_dephasing_cli

## C

Compile and run:

    gcc articles/quantum-information-decoherence-and-measurement/c/density_matrix_dephasing.c -o density_matrix_dephasing_c -lm
    ./density_matrix_dephasing_c
