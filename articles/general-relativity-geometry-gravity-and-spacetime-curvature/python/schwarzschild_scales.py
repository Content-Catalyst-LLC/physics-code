"""
Schwarzschild Scales

This workflow computes Schwarzschild radius, compactness, and
surface redshift factors for sample astrophysical objects.
"""

from pathlib import Path

import numpy as np
import pandas as pd


G = 6.67430e-11
C = 299792458.0


def schwarzschild_radius_m(mass_kg: float) -> float:
    """
    Compute Schwarzschild radius in meters.
    """
    return 2.0 * G * mass_kg / C**2


def redshift_factor(radius_m: float, schwarzschild_radius: float) -> float:
    """
    Compute Schwarzschild redshift factor for radius outside horizon.
    """
    if not np.isfinite(radius_m) or radius_m <= schwarzschild_radius:
        return np.nan
    return 1.0 / np.sqrt(1.0 - schwarzschild_radius / radius_m)


def main() -> None:
    """
    Compute compact-object Schwarzschild scales.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "compact_object_cases.csv"
    output_path = article_dir / "data" / "computed_schwarzschild_scales.csv"

    cases = pd.read_csv(input_path)
    cases["schwarzschild_radius_m"] = cases["mass_kg"].apply(schwarzschild_radius_m)
    cases["schwarzschild_radius_km"] = cases["schwarzschild_radius_m"] / 1000.0
    cases["compactness"] = cases["schwarzschild_radius_m"] / cases["radius_m"]
    cases["redshift_factor"] = cases.apply(
        lambda row: redshift_factor(row["radius_m"], row["schwarzschild_radius_m"]),
        axis=1,
    )
    cases["gravitational_redshift_z"] = cases["redshift_factor"] - 1.0

    cases.to_csv(output_path, index=False)

    print("Schwarzschild scales:")
    print(cases.round(10).to_string(index=False))


if __name__ == "__main__":
    main()
