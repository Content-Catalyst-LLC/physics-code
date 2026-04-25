"""
H-R Diagram Radius-Temperature-Luminosity Scaling

This workflow uses the solar-normalized Stefan-Boltzmann relation:

    L / L_sun = (R / R_sun)^2 * (T_eff / T_sun)^4

Rearranged:

    R / R_sun = sqrt( (L / L_sun) / (T_eff / T_sun)^4 )

The goal is to show how luminosity, radius, and effective temperature
are connected in H-R diagram reasoning.
"""

from pathlib import Path

import numpy as np
import pandas as pd


SUN_EFFECTIVE_TEMPERATURE_K = 5772.0


def radius_from_luminosity_temperature(
    luminosity_solar: np.ndarray,
    temperature_k: np.ndarray
) -> np.ndarray:
    """
    Estimate stellar radius in solar units from luminosity and temperature.

    Parameters
    ----------
    luminosity_solar:
        Luminosity in solar units.
    temperature_k:
        Effective temperature in kelvin.

    Returns
    -------
    np.ndarray
        Radius in solar units.
    """
    if np.any(luminosity_solar <= 0):
        raise ValueError("Luminosities must be positive.")

    if np.any(temperature_k <= 0):
        raise ValueError("Temperatures must be positive.")

    temperature_ratio = temperature_k / SUN_EFFECTIVE_TEMPERATURE_K
    return np.sqrt(luminosity_solar / temperature_ratio**4)


def main() -> None:
    """
    Generate an H-R-style table from sample spectral classes.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "main_sequence_sample.csv"
    output_path = article_dir / "data" / "computed_hr_radius_scaling.csv"

    stars = pd.read_csv(input_path)

    stars["luminosity_solar_scaling"] = stars["mass_solar"] ** 3.5
    stars["estimated_radius_solar_from_scaling"] = radius_from_luminosity_temperature(
        stars["luminosity_solar_scaling"].to_numpy(dtype=float),
        stars["temperature_k"].to_numpy(dtype=float),
    )

    stars.to_csv(output_path, index=False)

    print("H-R-style radius-temperature-luminosity table:")
    print(stars.round(6).to_string(index=False))

    print(f"\nSaved H-R scaling table to: {output_path}")


if __name__ == "__main__":
    main()
