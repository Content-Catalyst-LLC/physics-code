# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/scattering-theory-cross-sections-and-physical-inference/python/resonance_breit_wigner_fit.py
    python articles/scattering-theory-cross-sections-and-physical-inference/python/angular_cross_section_integration.py
    python articles/scattering-theory-cross-sections-and-physical-inference/python/born_approximation_gaussian_potential.py
    python articles/scattering-theory-cross-sections-and-physical-inference/python/partial_wave_phase_shift_table.py
    python articles/scattering-theory-cross-sections-and-physical-inference/python/event_rate_inference.py
    python articles/scattering-theory-cross-sections-and-physical-inference/python/detector_smearing_scaffold.py

## R

From the repository root:

    Rscript articles/scattering-theory-cross-sections-and-physical-inference/r/angular_cross_section_integration.R
    Rscript articles/scattering-theory-cross-sections-and-physical-inference/r/cross_section_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/scattering-theory-cross-sections-and-physical-inference/julia/scattering_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/scattering-theory-cross-sections-and-physical-inference/cpp/cross_section_sweep.cpp -o cross_section_sweep
    ./cross_section_sweep

## Fortran

Compile and run:

    gfortran articles/scattering-theory-cross-sections-and-physical-inference/fortran/angular_integration_table.f90 -o angular_integration_table
    ./angular_integration_table

## SQL

Run with SQLite:

    sqlite3 articles/scattering-theory-cross-sections-and-physical-inference/data/scattering.sqlite < articles/scattering-theory-cross-sections-and-physical-inference/sql/scattering_schema.sql

## Rust

Compile and run:

    rustc articles/scattering-theory-cross-sections-and-physical-inference/rust/scattering_cli.rs -o scattering_cli
    ./scattering_cli

## C

Compile and run:

    gcc articles/scattering-theory-cross-sections-and-physical-inference/c/angular_cross_section.c -o angular_cross_section_c -lm
    ./angular_cross_section_c
