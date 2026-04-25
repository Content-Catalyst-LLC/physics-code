# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/experimental-physics-measurement-noise-calibration-and-inference/python/noise_snr_uncertainty.py
    python articles/experimental-physics-measurement-noise-calibration-and-inference/python/calibration_curve_fit.py
    python articles/experimental-physics-measurement-noise-calibration-and-inference/python/monte_carlo_uncertainty.py
    python articles/experimental-physics-measurement-noise-calibration-and-inference/python/fourier_noise_diagnostics.py
    python articles/experimental-physics-measurement-noise-calibration-and-inference/python/bayesian_measurement_update.py

## R

From the repository root:

    Rscript articles/experimental-physics-measurement-noise-calibration-and-inference/r/calibration_residual_diagnostics.R
    Rscript articles/experimental-physics-measurement-noise-calibration-and-inference/r/uncertainty_budget_summary.R

Required R packages:

    install.packages(c("tidyverse", "broom"))

## Julia

Run:

    julia articles/experimental-physics-measurement-noise-calibration-and-inference/julia/experimental_physics_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/experimental-physics-measurement-noise-calibration-and-inference/cpp/signal_uncertainty_sweep.cpp -o signal_uncertainty_sweep
    ./signal_uncertainty_sweep

## Fortran

Compile and run:

    gfortran articles/experimental-physics-measurement-noise-calibration-and-inference/fortran/uncertainty_table.f90 -o uncertainty_table
    ./uncertainty_table

## SQL

Run with SQLite:

    sqlite3 articles/experimental-physics-measurement-noise-calibration-and-inference/data/experimental_physics.sqlite < articles/experimental-physics-measurement-noise-calibration-and-inference/sql/experimental_physics_schema.sql

## Rust

Compile and run:

    rustc articles/experimental-physics-measurement-noise-calibration-and-inference/rust/experimental_cli.rs -o experimental_cli
    ./experimental_cli

## C

Compile and run:

    gcc articles/experimental-physics-measurement-noise-calibration-and-inference/c/uncertainty_snr_table.c -o uncertainty_snr_table_c -lm
    ./uncertainty_snr_table_c
