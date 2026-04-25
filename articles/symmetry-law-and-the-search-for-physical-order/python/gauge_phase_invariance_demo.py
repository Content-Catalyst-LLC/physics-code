"""
Gauge-Phase Invariance Demonstration

This workflow demonstrates a simple global phase transformation:

    psi -> exp(i alpha) psi

The complex field changes phase, but its modulus squared remains invariant:

    |psi|^2 -> |psi|^2

This is not a full gauge theory. It is a compact computational example of
phase invariance.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Generate a phase-transformation invariance table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_gauge_phase_invariance.csv"

    x = np.linspace(0.0, 2.0 * np.pi, 25)
    psi = np.exp(1j * x)

    alpha = np.pi / 3.0
    transformed_psi = np.exp(1j * alpha) * psi

    table = pd.DataFrame(
        {
            "x": x,
            "psi_real": np.real(psi),
            "psi_imag": np.imag(psi),
            "psi_modulus_squared": np.abs(psi) ** 2,
            "transformed_real": np.real(transformed_psi),
            "transformed_imag": np.imag(transformed_psi),
            "transformed_modulus_squared": np.abs(transformed_psi) ** 2,
            "difference_in_modulus_squared": (
                np.abs(psi) ** 2 - np.abs(transformed_psi) ** 2
            ),
        }
    )

    table.to_csv(output_path, index=False)

    print("Gauge-phase invariance table:")
    print(table.head(10).round(8).to_string(index=False))
    print(f"\nSaved phase invariance table to: {output_path}")


if __name__ == "__main__":
    main()
