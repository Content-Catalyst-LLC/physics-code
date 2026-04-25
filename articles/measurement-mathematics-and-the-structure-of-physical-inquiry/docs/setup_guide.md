# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/measurement-mathematics-and-the-structure-of-physical-inquiry/python/nonlinear_pendulum_model.py
    python articles/measurement-mathematics-and-the-structure-of-physical-inquiry/python/pendulum_uncertainty_propagation.py
    python articles/measurement-mathematics-and-the-structure-of-physical-inquiry/python/dimensional_reasoning_table.py

## R

From the repository root:

    Rscript articles/measurement-mathematics-and-the-structure-of-physical-inquiry/r/pendulum_measurement_uncertainty.R
    Rscript articles/measurement-mathematics-and-the-structure-of-physical-inquiry/r/measurement_residual_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/measurement-mathematics-and-the-structure-of-physical-inquiry/julia/pendulum_model_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/measurement-mathematics-and-the-structure-of-physical-inquiry/cpp/pendulum_uncertainty_sweep.cpp -o pendulum_uncertainty_sweep
    ./pendulum_uncertainty_sweep

## Fortran

Compile and run:

    gfortran articles/measurement-mathematics-and-the-structure-of-physical-inquiry/fortran/pendulum_measurement_table.f90 -o pendulum_measurement_table
    ./pendulum_measurement_table

## SQL

Run with SQLite:

    sqlite3 articles/measurement-mathematics-and-the-structure-of-physical-inquiry/data/measurement_inquiry.sqlite < articles/measurement-mathematics-and-the-structure-of-physical-inquiry/sql/measurement_inquiry_schema.sql

## Rust

Compile and run:

    rustc articles/measurement-mathematics-and-the-structure-of-physical-inquiry/rust/pendulum_measurement_cli.rs -o pendulum_measurement_cli
    ./pendulum_measurement_cli

## C

Compile and run:

    gcc articles/measurement-mathematics-and-the-structure-of-physical-inquiry/c/pendulum_measurement_table.c -o pendulum_measurement_table_c -lm
    ./pendulum_measurement_table_c
