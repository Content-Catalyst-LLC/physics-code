"""
Dark-Sector Parameter Scan

This workflow performs a simplified scan over candidate mass and coupling.

Toy model:
    model_prediction = coupling^2 / mass_scale

This is not a physical production model. It is a reproducible scaffold
for thinking about parameter scans, constraints, and exclusion logic.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def toy_prediction(candidate_mass_gev: np.ndarray, coupling: np.ndarray) -> np.ndarray:
    """
    Compute a schematic prediction from mass and coupling.

    Parameters
    ----------
    candidate_mass_gev:
        Candidate particle mass in GeV.
    coupling:
        Dimensionless coupling.

    Returns
    -------
    np.ndarray
        Toy observable prediction.
    """
    return coupling**2 / np.sqrt(candidate_mass_gev)


def main() -> None:
    """
    Generate a parameter grid and flag points above a toy limit.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "dark_sector_parameter_scan.csv"

    masses_gev = np.logspace(0, 4, 40)
    couplings = np.logspace(-4, -1, 40)

    rows = []

    for mass_gev in masses_gev:
        for coupling in couplings:
            prediction = toy_prediction(np.array([mass_gev]), np.array([coupling]))[0]
            toy_limit = 1e-5
            rows.append(
                {
                    "candidate_mass_gev": mass_gev,
                    "coupling": coupling,
                    "toy_prediction": prediction,
                    "toy_limit": toy_limit,
                    "excluded_by_toy_limit": prediction > toy_limit,
                }
            )

    scan = pd.DataFrame(rows)
    scan.to_csv(output_path, index=False)

    print(scan.head(20).to_string(index=False))
    print(f"\nSaved parameter scan to: {output_path}")


if __name__ == "__main__":
    main()
