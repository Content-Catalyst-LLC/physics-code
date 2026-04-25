# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/topological-matter-and-quantum-phases/python/two_band_chern_model.py
    python articles/topological-matter-and-quantum-phases/python/berry_curvature_grid.py
    python articles/topological-matter-and-quantum-phases/python/wilson_loop_scaffold.py
    python articles/topological-matter-and-quantum-phases/python/kitaev_chain_diagnostics.py
    python articles/topological-matter-and-quantum-phases/python/edge_state_toy_model.py

## R

From the repository root:

    Rscript articles/topological-matter-and-quantum-phases/r/ssh_winding_number.R
    Rscript articles/topological-matter-and-quantum-phases/r/topological_phase_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/topological-matter-and-quantum-phases/julia/topological_band_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/topological-matter-and-quantum-phases/cpp/chern_phase_sweep.cpp -o chern_phase_sweep
    ./chern_phase_sweep

## Fortran

Compile and run:

    gfortran articles/topological-matter-and-quantum-phases/fortran/ssh_winding_table.f90 -o ssh_winding_table
    ./ssh_winding_table

## SQL

Run with SQLite:

    sqlite3 articles/topological-matter-and-quantum-phases/data/topological_matter.sqlite < articles/topological-matter-and-quantum-phases/sql/topological_matter_schema.sql

## Rust

Compile and run:

    rustc articles/topological-matter-and-quantum-phases/rust/topology_cli.rs -o topology_cli
    ./topology_cli

## C

Compile and run:

    gcc articles/topological-matter-and-quantum-phases/c/ssh_winding.c -o ssh_winding_c -lm
    ./ssh_winding_c
