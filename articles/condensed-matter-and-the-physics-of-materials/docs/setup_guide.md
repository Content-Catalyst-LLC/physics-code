# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/condensed-matter-and-the-physics-of-materials/python/band_phonon_dispersion.py
    python articles/condensed-matter-and-the-physics-of-materials/python/band_gap_classifier.py

## R

From the repository root:

    Rscript articles/condensed-matter-and-the-physics-of-materials/r/transport_resistivity_summary.R
    Rscript articles/condensed-matter-and-the-physics-of-materials/r/materials_property_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/condensed-matter-and-the-physics-of-materials/julia/tight_binding_lattice_model.jl

## C++

Compile and run:

    g++ -std=c++17 articles/condensed-matter-and-the-physics-of-materials/cpp/transport_parameter_sweep.cpp -o transport_parameter_sweep
    ./transport_parameter_sweep

## Fortran

Compile and run:

    gfortran articles/condensed-matter-and-the-physics-of-materials/fortran/phonon_dispersion_table.f90 -o phonon_dispersion_table
    ./phonon_dispersion_table

## SQL

Run with SQLite:

    sqlite3 articles/condensed-matter-and-the-physics-of-materials/data/condensed_matter.sqlite < articles/condensed-matter-and-the-physics-of-materials/sql/condensed_matter_schema.sql

## Rust

Compile and run:

    rustc articles/condensed-matter-and-the-physics-of-materials/rust/band_gap_classifier_cli.rs -o band_gap_classifier_cli
    ./band_gap_classifier_cli

## C

Compile and run:

    gcc articles/condensed-matter-and-the-physics-of-materials/c/resistivity_temperature_table.c -o resistivity_temperature_table -lm
    ./resistivity_temperature_table
