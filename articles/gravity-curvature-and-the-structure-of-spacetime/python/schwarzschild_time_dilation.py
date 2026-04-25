"""
Schwarzschild Radius and Clock-Rate Factors

This workflow computes:

    r_s = 2*G*M/c^2

and the Schwarzschild time-dilation factor for a stationary clock:

    d_tau/dt = sqrt(1 - r_s/r)

The calculation is educational scaffolding for Schwarzschild geometry.
It is not a full numerical-relativity simulation.
"""

from pathlib import Path

import numpy as np
import pandas as pd


G = 6.67430e-11
C = 299_792_458.0


def schwarzschild_radius(mass_kg: float) -> float:
    """
    Compute the Schwarzschild radius for a non-rotating spherical mass.
    """
    return 2.0 * G * mass_kg / C**2


def clock_rate_factor(radius_m: np.ndarray, schwarzschild_radius_m: float) -> np.ndarray:
    """
    Compute d_tau/dt for stationary clocks in Schwarzschild geometry.
    """
    if np.any(radius_m <= schwarzschild_radius_m):
        raise ValueError("All radius values must be outside the Schwarzschild radius.")

    return np.sqrt(1.0 - schwarzschild_radius_m / radius_m)


def main() -> None:
    """
    Compute radii and clock-rate factors for selected objects.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "mass_examples.csv"
    radii_output = article_dir / "data" / "computed_schwarzschild_radii.csv"
    clock_output = article_dir / "data" / "computed_clock_rate_factor.csv"

    objects = pd.read_csv(input_path)
    objects["schwarzschild_radius_m"] = objects["mass_kg"].apply(schwarzschild_radius)
    objects["schwarzschild_radius_km"] = objects["schwarzschild_radius_m"] / 1000.0

    solar_mass = 1.98847e30
    rs_sun = schwarzschild_radius(solar_mass)
    radius = np.linspace(1.05 * rs_sun, 20.0 * rs_sun, 1000)

    clock_table = pd.DataFrame(
        {
            "radius_over_rs": radius / rs_sun,
            "radius_m": radius,
            "clock_factor": clock_rate_factor(radius, rs_sun),
            "fractional_time_difference": 1.0 - clock_rate_factor(radius, rs_sun),
        }
    )

    objects.to_csv(radii_output, index=False)
    clock_table.to_csv(clock_output, index=False)

    print("Schwarzschild radii:")
    print(objects.to_string(index=False))

    print("\nClock-rate factors near a one-solar-mass Schwarzschild radius:")
    print(clock_table.head(12).round(8).to_string(index=False))

    print(f"\nSaved radii to: {radii_output}")
    print(f"Saved clock table to: {clock_output}")


if __name__ == "__main__":
    main()
