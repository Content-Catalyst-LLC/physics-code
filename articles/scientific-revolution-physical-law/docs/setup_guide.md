# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas matplotlib scipy
    python articles/scientific-revolution-physical-law/python/kepler_galileo_newton_models.py
    python articles/scientific-revolution-physical-law/python/kepler_parameter_sweep.py

## R

From the repository root:

    Rscript articles/scientific-revolution-physical-law/r/kepler_loglog_scaling.R

Required R packages:

    install.packages(c("tidyverse", "broom"))

## Julia

Run:

    julia articles/scientific-revolution-physical-law/julia/two_body_orbit_rk4.jl

## C++

Compile and run:

    g++ -std=c++17 articles/scientific-revolution-physical-law/cpp/orbit_velocity_verlet.cpp -o orbit_velocity_verlet
    ./orbit_velocity_verlet

## Fortran

Compile and run:

    gfortran articles/scientific-revolution-physical-law/fortran/free_fall_table.f90 -o free_fall_table
    ./free_fall_table

## SQL

Run with SQLite:

    sqlite3 articles/scientific-revolution-physical-law/data/scientific_revolution.sqlite < articles/scientific-revolution-physical-law/sql/scientific_revolution_schema.sql

## Rust

Compile and run:

    rustc articles/scientific-revolution-physical-law/rust/kepler_scaling_cli.rs -o kepler_scaling_cli
    ./kepler_scaling_cli

## C

Compile and run:

    gcc articles/scientific-revolution-physical-law/c/free_fall_estimator.c -o free_fall_estimator -lm
    ./free_fall_estimator
