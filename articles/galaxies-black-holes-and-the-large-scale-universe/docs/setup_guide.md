# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas matplotlib scipy
    python articles/galaxies-black-holes-and-the-large-scale-universe/python/enclosed_mass_black_hole_radius.py
    python articles/galaxies-black-holes-and-the-large-scale-universe/python/rotation_curve_parameter_sweep.py

## R

From the repository root:

    Rscript articles/galaxies-black-holes-and-the-large-scale-universe/r/rotation_curve_redshift_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/galaxies-black-holes-and-the-large-scale-universe/julia/circular_orbit_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/galaxies-black-holes-and-the-large-scale-universe/cpp/rotation_curve_sweep.cpp -o rotation_curve_sweep
    ./rotation_curve_sweep

## Fortran

Compile and run:

    gfortran articles/galaxies-black-holes-and-the-large-scale-universe/fortran/schwarzschild_radius_table.f90 -o schwarzschild_radius_table
    ./schwarzschild_radius_table

## SQL

Run with SQLite:

    sqlite3 articles/galaxies-black-holes-and-the-large-scale-universe/data/galaxies_black_holes.sqlite < articles/galaxies-black-holes-and-the-large-scale-universe/sql/galaxies_black_holes_schema.sql

## Rust

Compile and run:

    rustc articles/galaxies-black-holes-and-the-large-scale-universe/rust/black_hole_radius_cli.rs -o black_hole_radius_cli
    ./black_hole_radius_cli

## C

Compile and run:

    gcc articles/galaxies-black-holes-and-the-large-scale-universe/c/hubble_and_mass_table.c -o hubble_and_mass_table -lm
    ./hubble_and_mass_table
