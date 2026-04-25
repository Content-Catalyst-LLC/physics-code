# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/quantum-mechanics-and-the-limits-of-classical-intuition/python/particle_box_eigenstates.py
    python articles/quantum-mechanics-and-the-limits-of-classical-intuition/python/finite_difference_hamiltonian.py
    python articles/quantum-mechanics-and-the-limits-of-classical-intuition/python/gaussian_wavepacket_uncertainty.py

## R

From the repository root:

    Rscript articles/quantum-mechanics-and-the-limits-of-classical-intuition/r/particle_box_probability_density.R
    Rscript articles/quantum-mechanics-and-the-limits-of-classical-intuition/r/measurement_histogram_simulation.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/quantum-mechanics-and-the-limits-of-classical-intuition/julia/finite_difference_hamiltonian.jl

## C++

Compile and run:

    g++ -std=c++17 articles/quantum-mechanics-and-the-limits-of-classical-intuition/cpp/particle_box_energy_table.cpp -o particle_box_energy_table
    ./particle_box_energy_table

## Fortran

Compile and run:

    gfortran articles/quantum-mechanics-and-the-limits-of-classical-intuition/fortran/particle_box_energy_table.f90 -o particle_box_energy_table_f
    ./particle_box_energy_table_f

## SQL

Run with SQLite:

    sqlite3 articles/quantum-mechanics-and-the-limits-of-classical-intuition/data/quantum_mechanics.sqlite < articles/quantum-mechanics-and-the-limits-of-classical-intuition/sql/quantum_mechanics_schema.sql

## Rust

Compile and run:

    rustc articles/quantum-mechanics-and-the-limits-of-classical-intuition/rust/particle_box_cli.rs -o particle_box_cli
    ./particle_box_cli

## C

Compile and run:

    gcc articles/quantum-mechanics-and-the-limits-of-classical-intuition/c/particle_box_energy_table.c -o particle_box_energy_table_c -lm
    ./particle_box_energy_table_c
