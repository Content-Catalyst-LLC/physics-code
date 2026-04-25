"""
Binder Cumulant Scaffold

The Binder cumulant for an Ising-like order parameter is often written:

    U4 = 1 - <m^4> / (3 <m^2>^2)

This script generates synthetic-style examples from supplied moments.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def binder_cumulant(m2: float, m4: float) -> float:
    """
    Compute Binder cumulant from second and fourth moments.
    """
    if m2 <= 0.0:
        return np.nan
    return 1.0 - m4 / (3.0 * m2**2)


def main() -> None:
    """
    Create Binder cumulant scaffolding table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_binder_cumulant_scaffold.csv"

    rows = []

    for lattice_size in [16, 32, 64]:
        for temperature in np.linspace(2.0, 2.6, 7):
            distance = abs(temperature - 2.269185314)
            m2 = max(0.02, 0.8 / (1.0 + 10.0 * distance + lattice_size / 128.0))
            m4 = 3.0 * m2**2 * (0.35 + 0.25 * np.tanh(4.0 * distance))

            rows.append(
                {
                    "lattice_size": lattice_size,
                    "temperature": temperature,
                    "m2": m2,
                    "m4": m4,
                    "binder_cumulant": binder_cumulant(m2, m4),
                    "notes": "Synthetic scaffold for Binder cumulant workflow.",
                }
            )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Binder cumulant scaffold:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
