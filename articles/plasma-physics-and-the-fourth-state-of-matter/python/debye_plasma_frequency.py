"""
Debye Length and Plasma Frequency

This workflow computes Debye length and plasma frequency over density and
electron-temperature ranges.
"""

from pathlib import Path

import numpy as np
import pandas as pd


EPSILON_0 = 8.8541878128e-12
E_CHARGE = 1.602176634e-19
ELECTRON_MASS = 9.1093837015e-31


def main() -> None:
    """
    Generate Debye length and plasma frequency table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_debye_plasma_frequency_grid.csv"

    densities = np.logspace(6, 22, 17)
    temperatures_ev = np.array([0.1, 1.0, 10.0, 100.0, 1000.0])

    rows = []

    for ne in densities:
        for te_ev in temperatures_ev:
            te_j = te_ev * E_CHARGE
            lambda_d = np.sqrt(EPSILON_0 * te_j / (ne * E_CHARGE**2))
            omega_pe = np.sqrt(ne * E_CHARGE**2 / (EPSILON_0 * ELECTRON_MASS))
            n_debye = (4.0 * np.pi / 3.0) * ne * lambda_d**3

            rows.append(
                {
                    "electron_density_m3": ne,
                    "electron_temperature_ev": te_ev,
                    "debye_length_m": lambda_d,
                    "electron_plasma_frequency_hz": omega_pe / (2.0 * np.pi),
                    "debye_sphere_particles": n_debye,
                }
            )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Debye length and plasma frequency grid sample:")
    print(output.head(20).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
