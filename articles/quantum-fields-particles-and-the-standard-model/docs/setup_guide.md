# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/quantum-fields-particles-and-the-standard-model/python/yukawa_higgs_potential.py
    python articles/quantum-fields-particles-and-the-standard-model/python/running_coupling_toy_model.py
    python articles/quantum-fields-particles-and-the-standard-model/python/particle_metadata_summary.py

## R

From the repository root:

    Rscript articles/quantum-fields-particles-and-the-standard-model/r/yukawa_hierarchy_summary.R
    Rscript articles/quantum-fields-particles-and-the-standard-model/r/standard_model_particle_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/quantum-fields-particles-and-the-standard-model/julia/higgs_yukawa_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/quantum-fields-particles-and-the-standard-model/cpp/running_coupling_sweep.cpp -o running_coupling_sweep
    ./running_coupling_sweep

## Fortran

Compile and run:

    gfortran articles/quantum-fields-particles-and-the-standard-model/fortran/yukawa_table.f90 -o yukawa_table
    ./yukawa_table

## SQL

Run with SQLite:

    sqlite3 articles/quantum-fields-particles-and-the-standard-model/data/standard_model.sqlite < articles/quantum-fields-particles-and-the-standard-model/sql/standard_model_schema.sql

## Rust

Compile and run:

    rustc articles/quantum-fields-particles-and-the-standard-model/rust/yukawa_cli.rs -o yukawa_cli
    ./yukawa_cli

## C

Compile and run:

    gcc articles/quantum-fields-particles-and-the-standard-model/c/higgs_potential_table.c -o higgs_potential_table -lm
    ./higgs_potential_table
