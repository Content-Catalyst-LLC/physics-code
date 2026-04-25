# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas matplotlib scipy
    python articles/physics-beyond-the-standard-model/python/relic_density_scaling.py
    python articles/physics-beyond-the-standard-model/python/dark_sector_parameter_scan.py

## R

From the repository root:

    Rscript articles/physics-beyond-the-standard-model/r/cosmic_inventory_bsm_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/physics-beyond-the-standard-model/julia/freezeout_toy_dynamics.jl

## C++

Compile and run:

    g++ -std=c++17 articles/physics-beyond-the-standard-model/cpp/bsm_parameter_scan.cpp -o bsm_parameter_scan
    ./bsm_parameter_scan

## Fortran

Compile and run:

    gfortran articles/physics-beyond-the-standard-model/fortran/relic_scaling_table.f90 -o relic_scaling_table
    ./relic_scaling_table

## SQL

Run with SQLite:

    sqlite3 articles/physics-beyond-the-standard-model/data/bsm_metadata.sqlite < articles/physics-beyond-the-standard-model/sql/bsm_schema.sql

## Rust

Compile and run:

    rustc articles/physics-beyond-the-standard-model/rust/relic_scaling_cli.rs -o relic_scaling_cli
    ./relic_scaling_cli

## C

Compile and run:

    gcc articles/physics-beyond-the-standard-model/c/toy_likelihood_constraint.c -o toy_likelihood_constraint -lm
    ./toy_likelihood_constraint
