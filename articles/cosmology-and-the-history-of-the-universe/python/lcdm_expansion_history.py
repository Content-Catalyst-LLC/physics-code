"""
Simplified ΛCDM Expansion History

This workflow evaluates a simplified flat ΛCDM-style expansion function:

    H(z) = H0 * sqrt(
        Omega_m * (1 + z)^3
        + Omega_r * (1 + z)^4
        + Omega_lambda
    )

This is educational scaffolding and does not include curvature,
evolving dark energy, neutrino subtleties, or parameter inference.
"""

from pathlib import Path

import numpy as np
import pandas as pd


H0_KM_PER_S_PER_MPC = 70.0
OMEGA_M = 0.315
OMEGA_R = 0.00009
OMEGA_LAMBDA = 0.685


def lcdm_hubble_parameter(redshift: np.ndarray) -> np.ndarray:
    """
    Compute simplified flat ΛCDM expansion rate H(z).

    Parameters
    ----------
    redshift:
        Cosmological redshift.

    Returns
    -------
    np.ndarray
        Hubble expansion rate at redshift z in km/s/Mpc.
    """
    zp1 = 1.0 + redshift

    expansion_factor = np.sqrt(
        OMEGA_M * zp1**3
        + OMEGA_R * zp1**4
        + OMEGA_LAMBDA
    )

    return H0_KM_PER_S_PER_MPC * expansion_factor


def main() -> None:
    """
    Generate a simplified expansion-history table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_lcdm_expansion_history.csv"

    redshift = np.concatenate(
        [
            np.linspace(0, 5, 51),
            np.array([10, 20, 50, 100, 500, 1100], dtype=float),
        ]
    )

    expansion = pd.DataFrame(
        {
            "redshift": redshift,
            "scale_factor": 1.0 / (1.0 + redshift),
            "hubble_parameter_km_s_mpc": lcdm_hubble_parameter(redshift),
        }
    )

    expansion.to_csv(output_path, index=False)

    print(expansion.head(15).round(6).to_string(index=False))
    print(f"\nSaved expansion history to: {output_path}")


if __name__ == "__main__":
    main()
