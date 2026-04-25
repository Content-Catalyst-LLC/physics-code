"""
Relic-Density-Style Scaling

This workflow illustrates a simplified BSM intuition:

    Omega_chi h^2 ∝ 1 / <sigma v>

where:
    Omega_chi h^2 = schematic dark-matter abundance contribution
    <sigma v> = thermally averaged annihilation quantity

This is not a full relic-density calculation. It is a transparent toy
model for showing how abundance can scale inversely with annihilation
efficiency.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def relic_density_scaling(sigma_v: np.ndarray, normalization: float = 1.0) -> np.ndarray:
    """
    Compute schematic inverse relic-density scaling.

    Parameters
    ----------
    sigma_v:
        Thermally averaged annihilation quantity in schematic units.
    normalization:
        Arbitrary normalization constant for illustrative scaling.

    Returns
    -------
    np.ndarray
        Schematic relic abundance values.
    """
    if np.any(sigma_v <= 0):
        raise ValueError("All sigma_v values must be positive.")

    return normalization / sigma_v


def main() -> None:
    """
    Generate and save a relic-density-style scaling table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_relic_density_scaling.csv"

    sigma_v = np.logspace(-28, -24, 25)
    omega = relic_density_scaling(sigma_v, normalization=1e-26)

    table = pd.DataFrame(
        {
            "sigma_v_schematic": sigma_v,
            "omega_chi_h2_schematic": omega,
        }
    )

    table.to_csv(output_path, index=False)

    print("Illustrative inverse relic-density-style scaling")
    print(table.head(10).to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()
