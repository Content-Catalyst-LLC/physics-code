# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas
    python articles/physics-and-the-philosophy-of-reality/python/quantum_state_interpretations.py
    python articles/physics-and-the-philosophy-of-reality/python/basis_invariance_demo.py

## R

From the repository root:

    Rscript articles/physics-and-the-philosophy-of-reality/r/interpretive_taxonomy.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/physics-and-the-philosophy-of-reality/julia/two_state_unitary_evolution.jl

## C++

Compile and run:

    g++ -std=c++17 articles/physics-and-the-philosophy-of-reality/cpp/state_vector_probabilities.cpp -o state_vector_probabilities
    ./state_vector_probabilities

## Fortran

Compile and run:

    gfortran articles/physics-and-the-philosophy-of-reality/fortran/normalize_state_vector.f90 -o normalize_state_vector
    ./normalize_state_vector

## SQL

Run with SQLite:

    sqlite3 articles/physics-and-the-philosophy-of-reality/data/philosophy_of_reality.sqlite < articles/physics-and-the-philosophy-of-reality/sql/philosophy_of_reality_schema.sql

## Rust

Compile and run:

    rustc articles/physics-and-the-philosophy-of-reality/rust/born_rule_cli.rs -o born_rule_cli
    ./born_rule_cli

## C

Compile and run:

    gcc articles/physics-and-the-philosophy-of-reality/c/state_vector_normalization.c -o state_vector_normalization -lm
    ./state_vector_normalization
