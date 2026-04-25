# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/atoms-molecules-and-the-structure-of-matter/python/hydrogen_levels_diatomic_potential.py
    python articles/atoms-molecules-and-the-structure-of-matter/python/molecular_structure_summary.py

## R

From the repository root:

    Rscript articles/atoms-molecules-and-the-structure-of-matter/r/hydrogen_spectral_lines.R
    Rscript articles/atoms-molecules-and-the-structure-of-matter/r/atomic_molecular_summary.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/atoms-molecules-and-the-structure-of-matter/julia/photon_energy_bohr_levels.jl

## C++

Compile and run:

    g++ -std=c++17 articles/atoms-molecules-and-the-structure-of-matter/cpp/transition_energy_sweep.cpp -o transition_energy_sweep
    ./transition_energy_sweep

## Fortran

Compile and run:

    gfortran articles/atoms-molecules-and-the-structure-of-matter/fortran/bohr_energy_table.f90 -o bohr_energy_table
    ./bohr_energy_table

## SQL

Run with SQLite:

    sqlite3 articles/atoms-molecules-and-the-structure-of-matter/data/atoms_molecules.sqlite < articles/atoms-molecules-and-the-structure-of-matter/sql/atoms_molecules_schema.sql

## Rust

Compile and run:

    rustc articles/atoms-molecules-and-the-structure-of-matter/rust/photon_energy_cli.rs -o photon_energy_cli
    ./photon_energy_cli

## C

Compile and run:

    gcc articles/atoms-molecules-and-the-structure-of-matter/c/bohr_energy_table.c -o bohr_energy_table_c -lm
    ./bohr_energy_table_c
