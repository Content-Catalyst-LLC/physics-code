# Setup Guide

## Python

    python3 -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt

## R

Install article-specific packages as needed.

## Julia

Use article-specific `Project.toml` files where needed.

## C++

Compile examples with:

    g++ -std=c++17 example.cpp -o example

## Fortran

Compile examples with:

    gfortran example.f90 -o example

## Rust

Compile examples with:

    rustc example.rs -o example

## SQL

Run SQL examples with SQLite unless otherwise specified:

    sqlite3 physics.db < example.sql
