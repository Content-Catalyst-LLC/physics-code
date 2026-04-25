"""
Kepler, Galileo, and Newton Model Workflows

This script reconstructs three lawlike relations associated with the
Scientific Revolution and the rise of physical law:

1. Kepler-style orbital scaling:
       T = a^(3/2)

2. Galilean free fall from rest:
       s = 0.5 * g * t^2

3. Newtonian gravitational force magnitude:
       F = G * m1 * m2 / r^2

The goal is not historical anachronism. The goal is to show how early
physical laws can be represented as reproducible computational models.
"""

from pathlib import Path

import numpy as np
import pandas as pd


GRAVITY_M_PER_S2 = 9.80665
GRAVITATIONAL_CONSTANT_N_M2_PER_KG2 = 6.67430e-11


def kepler_period_years(semi_major_axis_au: np.ndarray) -> np.ndarray:
    """
    Compute normalized Kepler-style orbital period in Earth years.

    Parameters
    ----------
    semi_major_axis_au:
        Semi-major axis in astronomical units.

    Returns
    -------
    np.ndarray
        Orbital period in Earth years under T = a^(3/2).
    """
    return semi_major_axis_au ** 1.5


def free_fall_distance_m(time_s: np.ndarray) -> np.ndarray:
    """
    Compute ideal distance fallen from rest under constant gravity.

    Parameters
    ----------
    time_s:
        Time in seconds.

    Returns
    -------
    np.ndarray
        Distance in meters.
    """
    return 0.5 * GRAVITY_M_PER_S2 * time_s**2


def gravitational_force_n(mass_1_kg: float, mass_2_kg: float, radius_m: float) -> float:
    """
    Compute Newtonian gravitational force magnitude.

    Parameters
    ----------
    mass_1_kg:
        First mass in kilograms.
    mass_2_kg:
        Second mass in kilograms.
    radius_m:
        Separation distance in meters.

    Returns
    -------
    float
        Gravitational force in newtons.
    """
    if radius_m <= 0:
        raise ValueError("radius_m must be positive.")

    return (
        GRAVITATIONAL_CONSTANT_N_M2_PER_KG2
        * mass_1_kg
        * mass_2_kg
        / radius_m**2
    )


def main() -> None:
    article_dir = Path(__file__).resolve().parents[1]

    orbit_path = article_dir / "data" / "planetary_orbits_normalized.csv"
    free_fall_output = article_dir / "data" / "computed_free_fall_table.csv"
    orbit_output = article_dir / "data" / "computed_kepler_comparison.csv"

    orbits = pd.read_csv(orbit_path)
    orbits["kepler_predicted_period_years"] = kepler_period_years(
        orbits["semi_major_axis_au"].to_numpy()
    )
    orbits["period_residual_years"] = (
        orbits["orbital_period_years"] - orbits["kepler_predicted_period_years"]
    )

    time_s = np.linspace(0.0, 10.0, 21)
    free_fall = pd.DataFrame(
        {
            "time_s": time_s,
            "distance_m": free_fall_distance_m(time_s),
            "gravity_m_per_s2": GRAVITY_M_PER_S2,
        }
    )

    earth_mass_kg = 5.9722e24
    moon_mass_kg = 7.342e22
    earth_moon_distance_m = 3.844e8

    earth_moon_force_n = gravitational_force_n(
        earth_mass_kg,
        moon_mass_kg,
        earth_moon_distance_m,
    )

    orbits.to_csv(orbit_output, index=False)
    free_fall.to_csv(free_fall_output, index=False)

    print("Kepler-style orbital comparison")
    print(orbits.round(6).to_string(index=False))

    print("\nGalilean free-fall table")
    print(free_fall.round(6).to_string(index=False))

    print("\nNewtonian Earth-Moon gravitational force estimate")
    print(f"{earth_moon_force_n:.6e} N")

    print(f"\nSaved: {orbit_output}")
    print(f"Saved: {free_fall_output}")


if __name__ == "__main__":
    main()
