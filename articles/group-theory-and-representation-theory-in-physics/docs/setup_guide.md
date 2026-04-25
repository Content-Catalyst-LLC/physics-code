# Setup Guide

## Python

From the repository root:

    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy pandas scipy sympy
    python articles/group-theory-and-representation-theory-in-physics/python/angular_momentum_su2.py
    python articles/group-theory-and-representation-theory-in-physics/python/finite_group_character_decomposition.py
    python articles/group-theory-and-representation-theory-in-physics/python/representation_check.py
    python articles/group-theory-and-representation-theory-in-physics/python/lie_algebra_commutators.py
    python articles/group-theory-and-representation-theory-in-physics/python/tensor_product_scaffold.py
    python articles/group-theory-and-representation-theory-in-physics/python/point_group_metadata.py

## R

From the repository root:

    Rscript articles/group-theory-and-representation-theory-in-physics/r/c3_character_orthogonality.R
    Rscript articles/group-theory-and-representation-theory-in-physics/r/finite_group_decomposition.R

Required R packages:

    install.packages(c("tidyverse"))

## Julia

Run:

    julia articles/group-theory-and-representation-theory-in-physics/julia/group_theory_scaffold.jl

## C++

Compile and run:

    g++ -std=c++17 articles/group-theory-and-representation-theory-in-physics/cpp/angular_momentum_sweep.cpp -o angular_momentum_sweep
    ./angular_momentum_sweep

## Fortran

Compile and run:

    gfortran articles/group-theory-and-representation-theory-in-physics/fortran/character_table_c3.f90 -o character_table_c3
    ./character_table_c3

## SQL

Run with SQLite:

    sqlite3 articles/group-theory-and-representation-theory-in-physics/data/group_theory_physics.sqlite < articles/group-theory-and-representation-theory-in-physics/sql/group_theory_physics_schema.sql

## Rust

Compile and run:

    rustc articles/group-theory-and-representation-theory-in-physics/rust/group_theory_cli.rs -o group_theory_cli
    ./group_theory_cli

## C

Compile and run:

    gcc articles/group-theory-and-representation-theory-in-physics/c/c3_character_table.c -o c3_character_table_c -lm
    ./c3_character_table_c
