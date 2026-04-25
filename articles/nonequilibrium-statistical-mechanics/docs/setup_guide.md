# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy matplotlib
    python articles/nonequilibrium-statistical-mechanics/python/overdamped_langevin.py
    python articles/nonequilibrium-statistical-mechanics/python/fokker_planck_relaxation.py
    python articles/nonequilibrium-statistical-mechanics/python/green_kubo_diffusion.py
    python articles/nonequilibrium-statistical-mechanics/python/fluctuation_theorem_check.py
    python articles/nonequilibrium-statistical-mechanics/python/entropy_production_markov.py

## R

From the repository root:

    Rscript articles/nonequilibrium-statistical-mechanics/r/markov_entropy_production.R
    Rscript articles/nonequilibrium-statistical-mechanics/r/markov_parameter_sweep.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/nonequilibrium-statistical-mechanics/julia/markov_cycle_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/nonequilibrium-statistical-mechanics/cpp/langevin_trajectory.cpp -o langevin_trajectory
    ./langevin_trajectory

## Fortran

Compile and run:

    gfortran articles/nonequilibrium-statistical-mechanics/fortran/diffusion_table.f90 -o diffusion_table
    ./diffusion_table

## SQL

Run with SQLite:

    sqlite3 articles/nonequilibrium-statistical-mechanics/data/nonequilibrium.sqlite < articles/nonequilibrium-statistical-mechanics/sql/nonequilibrium_schema.sql

## Rust

Compile and run:

    rustc articles/nonequilibrium-statistical-mechanics/rust/entropy_cycle_cli.rs -o entropy_cycle_cli
    ./entropy_cycle_cli

## C

Compile and run:

    gcc articles/nonequilibrium-statistical-mechanics/c/markov_cycle_entropy.c -o markov_cycle_entropy_c -lm
    ./markov_cycle_entropy_c
