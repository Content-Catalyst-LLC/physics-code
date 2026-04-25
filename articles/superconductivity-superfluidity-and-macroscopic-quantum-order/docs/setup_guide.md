# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/superconductivity-superfluidity-and-macroscopic-quantum-order/python/josephson_dynamics.py
    python articles/superconductivity-superfluidity-and-macroscopic-quantum-order/python/ginzburg_landau_free_energy.py
    python articles/superconductivity-superfluidity-and-macroscopic-quantum-order/python/flux_quantization.py
    python articles/superconductivity-superfluidity-and-macroscopic-quantum-order/python/superfluid_vortex_phase.py
    python articles/superconductivity-superfluidity-and-macroscopic-quantum-order/python/bcs_gap_scaffold.py

## R

From the repository root:

    Rscript articles/superconductivity-superfluidity-and-macroscopic-quantum-order/r/ginzburg_landau_free_energy.R
    Rscript articles/superconductivity-superfluidity-and-macroscopic-quantum-order/r/order_parameter_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/superconductivity-superfluidity-and-macroscopic-quantum-order/julia/order_parameter_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/superconductivity-superfluidity-and-macroscopic-quantum-order/cpp/flux_phase_sweep.cpp -o flux_phase_sweep
    ./flux_phase_sweep

## Fortran

Compile and run:

    gfortran articles/superconductivity-superfluidity-and-macroscopic-quantum-order/fortran/gl_free_energy_table.f90 -o gl_free_energy_table
    ./gl_free_energy_table

## SQL

Run with SQLite:

    sqlite3 articles/superconductivity-superfluidity-and-macroscopic-quantum-order/data/macroscopic_quantum_order.sqlite < articles/superconductivity-superfluidity-and-macroscopic-quantum-order/sql/macroscopic_quantum_order_schema.sql

## Rust

Compile and run:

    rustc articles/superconductivity-superfluidity-and-macroscopic-quantum-order/rust/mqo_cli.rs -o mqo_cli
    ./mqo_cli

## C

Compile and run:

    gcc articles/superconductivity-superfluidity-and-macroscopic-quantum-order/c/gl_free_energy.c -o gl_free_energy_c -lm
    ./gl_free_energy_c
