"""
Enclosed Mass and Black Hole Radius

This workflow demonstrates two foundational astrophysical calculations:

1. Enclosed mass from circular velocity:
       M(r) = v(r)^2 * r / G

2. Schwarzschild radius:
       r_s = 2GM / c^2

The calculations are educational scaffolding. They are not a full galaxy
dynamics model or a relativistic black-hole accretion model.
"""

from pathlib import Path

import numpy as np
import pandas as pd


G_SI = 6.67430e-11
C_M_PER_S = 299_792_458.0
M_SUN_KG = 1.98847e30
KPC_TO_M = 3.085677581491367e19


def enclosed_mass_solar(radius_kpc: np.ndarray, velocity_km_s: np.ndarray) -> np.ndarray:
    """
    Estimate enclosed mass from orbital speed and radius.

    Parameters
    ----------
    radius_kpc:
        Radius in kiloparsecs.
    velocity_km_s:
        Orbital speed in kilometers per second.

    Returns
    -------
    np.ndarray
        Enclosed mass in solar masses.
    """
    radius_m = radius_kpc * KPC_TO_M
    velocity_m_s = velocity_km_s * 1000.0
    mass_kg = (velocity_m_s**2 * radius_m) / G_SI
    return mass_kg / M_SUN_KG


def schwarzschild_radius_km(black_hole_mass_solar: np.ndarray) -> np.ndarray:
    """
    Compute Schwarzschild radius for a nonrotating black hole.

    Parameters
    ----------
    black_hole_mass_solar:
        Black-hole mass in solar masses.

    Returns
    -------
    np.ndarray
        Schwarzschild radius in kilometers.
    """
    mass_kg = black_hole_mass_solar * M_SUN_KG
    radius_m = 2.0 * G_SI * mass_kg / C_M_PER_S**2
    return radius_m / 1000.0


def main() -> None:
    """
    Generate enclosed-mass and Schwarzschild-radius tables.
    """
    article_dir = Path(__file__).resolve().parents[1]

    rotation_input = article_dir / "data" / "rotation_curve_sample.csv"
    black_hole_input = article_dir / "data" / "black_hole_mass_sample.csv"

    rotation_output = article_dir / "data" / "computed_enclosed_mass.csv"
    black_hole_output = article_dir / "data" / "computed_black_hole_radius.csv"

    rotation = pd.read_csv(rotation_input)
    rotation["enclosed_mass_solar"] = enclosed_mass_solar(
        rotation["radius_kpc"].to_numpy(dtype=float),
        rotation["observed_velocity_km_s"].to_numpy(dtype=float),
    )

    black_holes = pd.read_csv(black_hole_input)
    black_holes["schwarzschild_radius_km"] = schwarzschild_radius_km(
        black_holes["black_hole_mass_solar"].to_numpy(dtype=float)
    )

    rotation.to_csv(rotation_output, index=False)
    black_holes.to_csv(black_hole_output, index=False)

    print("Enclosed mass from schematic rotation curve:")
    print(rotation.round(5).to_string(index=False))

    print("\nSchwarzschild radius estimates:")
    print(black_holes.round(5).to_string(index=False))

    print(f"\nSaved: {rotation_output}")
    print(f"Saved: {black_hole_output}")


if __name__ == "__main__":
    main()
