# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas matplotlib scipy
    python articles/what-is-physics/python/pendulum_model_and_residuals.py
    python articles/what-is-physics/python/pendulum_parameter_sweep.py

## R

From the repository root, run:

    Rscript articles/what-is-physics/r/pendulum_measurement_uncertainty.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/what-is-physics/julia/pendulum_rk4_simulation.jl

## C++

Compile and run:

    g++ -std=c++17 articles/what-is-physics/cpp/pendulum_symplectic_euler.cpp -o pendulum_symplectic_euler
    ./pendulum_symplectic_euler

## Fortran

Compile and run:

    gfortran articles/what-is-physics/fortran/harmonic_oscillator_verlet.f90 -o harmonic_oscillator_verlet
    ./harmonic_oscillator_verlet

## SQL

Run with SQLite:

    sqlite3 articles/what-is-physics/data/physics_intro.sqlite < articles/what-is-physics/sql/physics_intro_schema.sql

## Rust

Compile and run:

    rustc articles/what-is-physics/rust/pendulum_period_cli.rs -o pendulum_period_cli
    ./pendulum_period_cli

## C

Compile and run:

    gcc articles/what-is-physics/c/instrument_period_estimator.c -o instrument_period_estimator -lm
    ./instrument_period_estimator
