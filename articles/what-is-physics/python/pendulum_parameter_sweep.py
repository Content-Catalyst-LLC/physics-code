"""
Pendulum Parameter Sweep

This script creates a reproducible parameter sweep for the ideal pendulum
period across a range of lengths.

The goal is to show how a compact physical law can generate a structured
model dataset for later visualization, comparison, or database ingestion.
"""

from pathlib import Path

import numpy as np
import pandas as pd


GRAVITY_M_PER_S2 = 9.80665


def ideal_pendulum_period(length_m: np.ndarray) -> np.ndarray:
    """
    Compute small-angle pendulum period for an array of lengths.

    Parameters
    ----------
    length_m:
        Pendulum length in meters.

    Returns
    -------
    np.ndarray
        Period in seconds.
    """
    return 2.0 * np.pi * np.sqrt(length_m / GRAVITY_M_PER_S2)


def main() -> None:
    """
    Generate a parameter sweep from 0.10 m to 2.00 m.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "pendulum_parameter_sweep.csv"

    length_m = np.linspace(0.10, 2.00, 200)
    period_s = ideal_pendulum_period(length_m)

    sweep = pd.DataFrame(
        {
            "length_m": length_m,
            "gravity_m_per_s2": GRAVITY_M_PER_S2,
            "predicted_period_s": period_s,
        }
    )

    sweep.to_csv(output_path, index=False)

    print(sweep.head().round(5).to_string(index=False))
    print(f"\nSaved parameter sweep to: {output_path}")


if __name__ == "__main__":
    main()
