# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/waves-oscillations-and-resonance/python/damped_driven_oscillator.py
    python articles/waves-oscillations-and-resonance/python/resonance_parameter_sweep.py
    python articles/waves-oscillations-and-resonance/python/wave_equation_string_scaffold.py
    python articles/waves-oscillations-and-resonance/python/fourier_signal_decomposition.py

## R

From the repository root:

    Rscript articles/waves-oscillations-and-resonance/r/resonance_curve.R
    Rscript articles/waves-oscillations-and-resonance/r/wave_speed_frequency_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/waves-oscillations-and-resonance/julia/oscillator_wave_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/waves-oscillations-and-resonance/cpp/resonance_parameter_sweep.cpp -o resonance_parameter_sweep
    ./resonance_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/waves-oscillations-and-resonance/fortran/standing_wave_table.f90 -o standing_wave_table
    ./standing_wave_table

## SQL

Run with SQLite:

    sqlite3 articles/waves-oscillations-and-resonance/data/waves_oscillations.sqlite < articles/waves-oscillations-and-resonance/sql/waves_oscillations_schema.sql

## Rust

Compile and run:

    rustc articles/waves-oscillations-and-resonance/rust/wave_oscillator_cli.rs -o wave_oscillator_cli
    ./wave_oscillator_cli

## C

Compile and run:

    gcc articles/waves-oscillations-and-resonance/c/resonance_table.c -o resonance_table_c -lm
    ./resonance_table_c
