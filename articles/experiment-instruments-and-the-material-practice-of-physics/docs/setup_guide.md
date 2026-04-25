# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/experiment-instruments-and-the-material-practice-of-physics/python/pendulum_uncertainty.py
    python articles/experiment-instruments-and-the-material-practice-of-physics/python/calibration_fit_and_residuals.py
    python articles/experiment-instruments-and-the-material-practice-of-physics/python/detector_signal_chain_simulation.py

## R

From the repository root:

    Rscript articles/experiment-instruments-and-the-material-practice-of-physics/r/pendulum_repeated_measurements.R
    Rscript articles/experiment-instruments-and-the-material-practice-of-physics/r/calibration_residual_summary.R

Required R packages:

    install.packages(c("tidyverse", "broom"))

## Julia

Run:

    julia articles/experiment-instruments-and-the-material-practice-of-physics/julia/measurement_model_uncertainty.jl

## C++

Compile and run:

    g++ -std=c++17 articles/experiment-instruments-and-the-material-practice-of-physics/cpp/detector_signal_chain_sweep.cpp -o detector_signal_chain_sweep
    ./detector_signal_chain_sweep

## Fortran

Compile and run:

    gfortran articles/experiment-instruments-and-the-material-practice-of-physics/fortran/uncertainty_table.f90 -o uncertainty_table
    ./uncertainty_table

## SQL

Run with SQLite:

    sqlite3 articles/experiment-instruments-and-the-material-practice-of-physics/data/experimental_physics.sqlite < articles/experiment-instruments-and-the-material-practice-of-physics/sql/experimental_physics_schema.sql

## Rust

Compile and run:

    rustc articles/experiment-instruments-and-the-material-practice-of-physics/rust/pendulum_uncertainty_cli.rs -o pendulum_uncertainty_cli
    ./pendulum_uncertainty_cli

## C

Compile and run:

    gcc articles/experiment-instruments-and-the-material-practice-of-physics/c/pendulum_uncertainty.c -o pendulum_uncertainty_c -lm
    ./pendulum_uncertainty_c
