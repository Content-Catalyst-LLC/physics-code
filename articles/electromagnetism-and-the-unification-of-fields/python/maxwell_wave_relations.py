"""
Maxwell Wave Relations

This workflow checks the vacuum electromagnetic wave relation:

    c = 1 / sqrt(mu0 * epsilon0)

using current CODATA-style values for vacuum permeability and permittivity.

It also computes wavelength-frequency pairs for selected frequencies.
"""

from pathlib import Path

import numpy as np
import pandas as pd


C = 299_792_458.0
EPSILON0 = 8.854_187_8188e-12
MU0 = 1.256_637_06127e-6


def main() -> None:
    """
    Compute wave-speed and wavelength-frequency tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_maxwell_wave_relations.csv"

    c_from_constants = 1.0 / np.sqrt(MU0 * EPSILON0)

    frequencies_hz = np.array([1e3, 1e6, 1e9, 1e12, 5e14, 1e18])

    table = pd.DataFrame(
        {
            "frequency_hz": frequencies_hz,
            "wavelength_m": C / frequencies_hz,
            "c_exact_m_per_s": C,
            "c_from_mu0_epsilon0_m_per_s": c_from_constants,
            "relative_difference": (c_from_constants - C) / C,
        }
    )

    table.to_csv(output_path, index=False)

    print("Maxwell wave relation table:")
    print(table.to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()
