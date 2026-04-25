"""
Hubble Relation, Scale Factor, and Radiation Temperature Tables

This workflow demonstrates three foundational cosmology relations:

1. Low-redshift Hubble relation:
       v = H0 * d

2. Scale factor from redshift:
       a = 1 / (1 + z)

3. Radiation temperature scaling:
       T(z) = T0 * (1 + z)

The calculations are educational scaffolding, not precision cosmology.
"""

from pathlib import Path

import numpy as np
import pandas as pd


H0_KM_PER_S_PER_MPC = 70.0
CMB_TEMPERATURE_K = 2.7255


def hubble_velocity(distance_mpc: np.ndarray) -> np.ndarray:
    """
    Compute low-redshift recessional velocity from distance.

    Parameters
    ----------
    distance_mpc:
        Distance in megaparsecs.

    Returns
    -------
    np.ndarray
        Recessional velocity in kilometers per second.
    """
    return H0_KM_PER_S_PER_MPC * distance_mpc


def scale_factor_from_redshift(redshift: np.ndarray) -> np.ndarray:
    """
    Convert redshift to scale factor using a = 1 / (1 + z).

    Parameters
    ----------
    redshift:
        Cosmological redshift.

    Returns
    -------
    np.ndarray
        Dimensionless scale factor.
    """
    if np.any(redshift < 0):
        raise ValueError("Redshift values should be nonnegative for this workflow.")

    return 1.0 / (1.0 + redshift)


def radiation_temperature(redshift: np.ndarray) -> np.ndarray:
    """
    Estimate radiation temperature at redshift z.

    Parameters
    ----------
    redshift:
        Cosmological redshift.

    Returns
    -------
    np.ndarray
        Radiation temperature in kelvin.
    """
    return CMB_TEMPERATURE_K * (1.0 + redshift)


def main() -> None:
    """
    Generate and save simple cosmology tables.
    """
    article_dir = Path(__file__).resolve().parents[1]

    hubble_input = article_dir / "data" / "hubble_reference_points.csv"
    hubble_output = article_dir / "data" / "computed_hubble_table.csv"
    redshift_output = article_dir / "data" / "computed_redshift_scale_factor_temperature.csv"

    hubble_table = pd.read_csv(hubble_input)
    hubble_table["recessional_velocity_km_s"] = hubble_velocity(
        hubble_table["distance_mpc"].to_numpy(dtype=float)
    )

    redshift = np.array([0, 0.5, 1, 2, 3, 10, 100, 1100], dtype=float)

    redshift_table = pd.DataFrame(
        {
            "redshift": redshift,
            "scale_factor": scale_factor_from_redshift(redshift),
            "radiation_temperature_k": radiation_temperature(redshift),
        }
    )

    hubble_table.to_csv(hubble_output, index=False)
    redshift_table.to_csv(redshift_output, index=False)

    print("Low-redshift Hubble relation:")
    print(hubble_table.round(6).to_string(index=False))

    print("\nRedshift, scale factor, and radiation temperature:")
    print(redshift_table.round(8).to_string(index=False))

    print(f"\nSaved: {hubble_output}")
    print(f"Saved: {redshift_output}")


if __name__ == "__main__":
    main()
