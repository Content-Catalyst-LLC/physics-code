"""
Relativistic Doppler Shift

This workflow computes approach and recession Doppler factors:

Approach:
    D = sqrt((1 + beta) / (1 - beta))

Recession:
    D = sqrt((1 - beta) / (1 + beta))

Observed frequency:
    f_obs = D * f_src
"""

from pathlib import Path

import numpy as np
import pandas as pd


def doppler_factor(beta: np.ndarray, approach: bool = True) -> np.ndarray:
    """
    Compute the relativistic Doppler factor for line-of-sight motion.
    """
    if np.any(np.abs(beta) >= 1):
        raise ValueError("All beta values must satisfy |beta| < 1.")

    if approach:
        return np.sqrt((1.0 + beta) / (1.0 - beta))

    return np.sqrt((1.0 - beta) / (1.0 + beta))


def main() -> None:
    """
    Generate Doppler factors for a range of beta values.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_relativistic_doppler_shift.csv"

    beta = np.linspace(0.0, 0.99, 200)
    source_frequency_hz = 1.0e9

    table = pd.DataFrame(
        {
            "beta": beta,
            "approach_doppler_factor": doppler_factor(beta, approach=True),
            "recession_doppler_factor": doppler_factor(beta, approach=False),
        }
    )

    table["source_frequency_hz"] = source_frequency_hz
    table["approach_observed_frequency_hz"] = (
        table["source_frequency_hz"] * table["approach_doppler_factor"]
    )
    table["recession_observed_frequency_hz"] = (
        table["source_frequency_hz"] * table["recession_doppler_factor"]
    )

    table.to_csv(output_path, index=False)

    print("Relativistic Doppler shift table:")
    print(table.head(12).round(8).to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()
