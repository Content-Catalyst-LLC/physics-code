# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/semiconductor-physics-and-electronic-materials/python/diode_iv_curve.py
    python articles/semiconductor-physics-and-electronic-materials/python/intrinsic_carrier_concentration.py
    python articles/semiconductor-physics-and-electronic-materials/python/pn_junction_electrostatics.py
    python articles/semiconductor-physics-and-electronic-materials/python/mos_capacitance.py
    python articles/semiconductor-physics-and-electronic-materials/python/mobility_conductivity_model.py

## R

From the repository root:

    Rscript articles/semiconductor-physics-and-electronic-materials/r/conductivity_doping_sensitivity.R
    Rscript articles/semiconductor-physics-and-electronic-materials/r/resistivity_temperature_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/semiconductor-physics-and-electronic-materials/julia/semiconductor_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/semiconductor-physics-and-electronic-materials/cpp/diode_parameter_sweep.cpp -o diode_parameter_sweep
    ./diode_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/semiconductor-physics-and-electronic-materials/fortran/junction_table.f90 -o junction_table
    ./junction_table

## SQL

Run with SQLite:

    sqlite3 articles/semiconductor-physics-and-electronic-materials/data/semiconductor_physics.sqlite < articles/semiconductor-physics-and-electronic-materials/sql/semiconductor_physics_schema.sql

## Rust

Compile and run:

    rustc articles/semiconductor-physics-and-electronic-materials/rust/semiconductor_cli.rs -o semiconductor_cli
    ./semiconductor_cli

## C

Compile and run:

    gcc articles/semiconductor-physics-and-electronic-materials/c/diode_conductivity_table.c -o diode_conductivity_table_c -lm
    ./diode_conductivity_table_c
