# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas matplotlib scipy
    python articles/physics-technology-and-the-modern-world/python/timing_power_scaling.py
    python articles/physics-technology-and-the-modern-world/python/semiconductor_rc_delay_sweep.py

## R

From the repository root:

    Rscript articles/physics-technology-and-the-modern-world/r/timing_uncertainty_analysis.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/physics-technology-and-the-modern-world/julia/heat_diffusion_1d.jl

## C++

Compile and run:

    g++ -std=c++17 articles/physics-technology-and-the-modern-world/cpp/rc_delay_parameter_sweep.cpp -o rc_delay_parameter_sweep
    ./rc_delay_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/physics-technology-and-the-modern-world/fortran/heat_diffusion_explicit.f90 -o heat_diffusion_explicit
    ./heat_diffusion_explicit

## SQL

Run with SQLite:

    sqlite3 articles/physics-technology-and-the-modern-world/data/physics_technology.sqlite < articles/physics-technology-and-the-modern-world/sql/physics_technology_schema.sql

## Rust

Compile and run:

    rustc articles/physics-technology-and-the-modern-world/rust/timing_error_cli.rs -o timing_error_cli
    ./timing_error_cli

## C

Compile and run:

    gcc articles/physics-technology-and-the-modern-world/c/sensor_voltage_conversion.c -o sensor_voltage_conversion
    ./sensor_voltage_conversion
