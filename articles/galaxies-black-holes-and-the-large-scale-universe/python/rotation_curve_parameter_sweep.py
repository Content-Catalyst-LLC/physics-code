"""
Rotation-Curve Parameter Sweep

This workflow creates a simple parameter sweep for circular velocity and
radius, then computes enclosed mass:

    M(r) = v(r)^2 * r / G

It is designed as transparent scaffolding for galaxy-dynamics intuition.
"""

from pathlib import Path

import numpy as np
import pandas as pd


G_SI = 6.67430e-11
M_SUN_KG = 1.98847e30
KPC_TO_M = 3.085677581491367e19


def enclosed_mass_solar(radius_kpc: float, velocity_km_s: float) -> float:
    """
    Estimate enclosed mass in solar masses.

    Parameters
    ----------
    radius_kpc:
        Radius in kiloparsecs.
    velocity_km_s:
        Circular velocity in kilometers per second.

    Returns
    -------
    float
        Enclosed mass in solar masses.
    """
    radius_m = radius_kpc * KPC_TO_M
    velocity_m_s = velocity_km_s * 1000.0
    mass_kg = velocity_m_s**2 * radius_m / G_SI
    return mass_kg / M_SUN_KG


def main() -> None:
    """
    Generate a sweep over radius and velocity values.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "rotation_curve_parameter_sweep.csv"

    radii_kpc = np.array([2, 5, 10, 15, 20, 30, 50], dtype=float)
    velocities_km_s = np.array([100, 150, 200, 220, 250, 300], dtype=float)

    rows = []

    for radius_kpc in radii_kpc:
        for velocity_km_s in velocities_km_s:
            rows.append(
                {
                    "radius_kpc": radius_kpc,
                    "velocity_km_s": velocity_km_s,
                    "enclosed_mass_solar": enclosed_mass_solar(radius_kpc, velocity_km_s),
                }
            )

    sweep = pd.DataFrame(rows)
    sweep.to_csv(output_path, index=False)

    print(sweep.head(20).round(5).to_string(index=False))
    print(f"\nSaved parameter sweep to: {output_path}")


if __name__ == "__main__":
    main()
