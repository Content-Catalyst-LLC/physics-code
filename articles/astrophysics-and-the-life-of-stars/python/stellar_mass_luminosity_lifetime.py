"""
Stellar Mass-Luminosity and Lifetime Scaling

This workflow demonstrates two introductory stellar-physics relations:

1. Approximate mass-luminosity scaling:
       L / L_sun = (M / M_sun)^3.5

2. Approximate main-sequence lifetime scaling:
       t / t_sun = M / L

The calculations are educational approximations, not full stellar-evolution
models.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def luminosity_from_mass(mass_solar: np.ndarray) -> np.ndarray:
    """
    Estimate luminosity from mass using a simple main-sequence scaling.

    Parameters
    ----------
    mass_solar:
        Stellar mass in solar units.

    Returns
    -------
    np.ndarray
        Luminosity in solar units.
    """
    if np.any(mass_solar <= 0):
        raise ValueError("All stellar masses must be positive.")

    return mass_solar**3.5


def lifetime_from_mass_and_luminosity(
    mass_solar: np.ndarray,
    luminosity_solar: np.ndarray
) -> np.ndarray:
    """
    Estimate relative main-sequence lifetime from mass and luminosity.

    Parameters
    ----------
    mass_solar:
        Stellar mass in solar units.
    luminosity_solar:
        Stellar luminosity in solar units.

    Returns
    -------
    np.ndarray
        Lifetime in units of the Sun's main-sequence lifetime.
    """
    return mass_solar / luminosity_solar


def main() -> None:
    """
    Load a sample main-sequence table and compute scaling quantities.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "main_sequence_sample.csv"
    output_path = article_dir / "data" / "computed_stellar_scaling.csv"

    stars = pd.read_csv(input_path)

    stars["luminosity_solar_scaling"] = luminosity_from_mass(
        stars["mass_solar"].to_numpy(dtype=float)
    )

    stars["main_sequence_lifetime_relative_to_sun"] = (
        lifetime_from_mass_and_luminosity(
            stars["mass_solar"].to_numpy(dtype=float),
            stars["luminosity_solar_scaling"].to_numpy(dtype=float),
        )
    )

    stars.to_csv(output_path, index=False)

    print("Illustrative stellar scaling table:")
    print(stars.round(6).to_string(index=False))

    print(f"\nSaved scaling table to: {output_path}")


if __name__ == "__main__":
    main()
