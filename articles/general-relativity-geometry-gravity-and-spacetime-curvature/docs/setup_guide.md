# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy sympy matplotlib
    python articles/general-relativity-geometry-gravity-and-spacetime-curvature/python/schwarzschild_scales.py
    python articles/general-relativity-geometry-gravity-and-spacetime-curvature/python/weak_field_precession.py
    python articles/general-relativity-geometry-gravity-and-spacetime-curvature/python/gravitational_redshift.py
    python articles/general-relativity-geometry-gravity-and-spacetime-curvature/python/curvature_symbolic_sphere.py
    python articles/general-relativity-geometry-gravity-and-spacetime-curvature/python/cosmology_friedmann_scales.py

## R

From the repository root:

    Rscript articles/general-relativity-geometry-gravity-and-spacetime-curvature/r/schwarzschild_redshift_summary.R
    Rscript articles/general-relativity-geometry-gravity-and-spacetime-curvature/r/relativity_scale_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/general-relativity-geometry-gravity-and-spacetime-curvature/julia/relativity_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/general-relativity-geometry-gravity-and-spacetime-curvature/cpp/weak_field_orbit_sweep.cpp -o weak_field_orbit_sweep
    ./weak_field_orbit_sweep

## Fortran

Compile and run:

    gfortran articles/general-relativity-geometry-gravity-and-spacetime-curvature/fortran/schwarzschild_table.f90 -o schwarzschild_table
    ./schwarzschild_table

## SQL

Run with SQLite:

    sqlite3 articles/general-relativity-geometry-gravity-and-spacetime-curvature/data/general_relativity.sqlite < articles/general-relativity-geometry-gravity-and-spacetime-curvature/sql/general_relativity_schema.sql

## Rust

Compile and run:

    rustc articles/general-relativity-geometry-gravity-and-spacetime-curvature/rust/relativity_cli.rs -o relativity_cli
    ./relativity_cli

## C

Compile and run:

    gcc articles/general-relativity-geometry-gravity-and-spacetime-curvature/c/schwarzschild_redshift_table.c -o schwarzschild_redshift_table_c -lm
    ./schwarzschild_redshift_table_c
