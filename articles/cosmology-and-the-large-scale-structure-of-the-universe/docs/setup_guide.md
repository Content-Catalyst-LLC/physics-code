# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/cosmology-and-the-large-scale-structure-of-the-universe/python/flrw_distances.py
    python articles/cosmology-and-the-large-scale-structure-of-the-universe/python/growth_and_power_spectrum.py
    python articles/cosmology-and-the-large-scale-structure-of-the-universe/python/bao_scale_scaffold.py
    python articles/cosmology-and-the-large-scale-structure-of-the-universe/python/survey_metadata_summary.py
    python articles/cosmology-and-the-large-scale-structure-of-the-universe/python/simulation_summary.py

## R

From the repository root:

    Rscript articles/cosmology-and-the-large-scale-structure-of-the-universe/r/flrw_expansion_distances.R
    Rscript articles/cosmology-and-the-large-scale-structure-of-the-universe/r/cosmology_parameter_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/cosmology-and-the-large-scale-structure-of-the-universe/julia/cosmology_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/cosmology-and-the-large-scale-structure-of-the-universe/cpp/flrw_distance_sweep.cpp -o flrw_distance_sweep
    ./flrw_distance_sweep

## Fortran

Compile and run:

    gfortran articles/cosmology-and-the-large-scale-structure-of-the-universe/fortran/expansion_table.f90 -o expansion_table
    ./expansion_table

## SQL

Run with SQLite:

    sqlite3 articles/cosmology-and-the-large-scale-structure-of-the-universe/data/cosmology.sqlite < articles/cosmology-and-the-large-scale-structure-of-the-universe/sql/cosmology_schema.sql

## Rust

Compile and run:

    rustc articles/cosmology-and-the-large-scale-structure-of-the-universe/rust/cosmology_cli.rs -o cosmology_cli
    ./cosmology_cli

## C

Compile and run:

    gcc articles/cosmology-and-the-large-scale-structure-of-the-universe/c/flrw_table.c -o flrw_table_c -lm
    ./flrw_table_c
