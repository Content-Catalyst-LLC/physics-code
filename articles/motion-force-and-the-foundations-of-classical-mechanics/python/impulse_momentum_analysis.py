"""
Impulse-Momentum Analysis

This workflow integrates a force-time curve to compute impulse:

    J = integral F dt

and then estimates velocity change:

    Delta v = J / m

for a constant-mass object.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def trapezoidal_impulse(time_s: np.ndarray, force_n: np.ndarray) -> float:
    """
    Compute impulse from force-time measurements using trapezoidal integration.
    """
    return float(np.trapz(force_n, time_s))


def main() -> None:
    """
    Compute impulse and velocity change from force-time measurements.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "force_time_measurements.csv"
    output_path = article_dir / "data" / "computed_impulse_momentum_summary.csv"

    measurements = pd.read_csv(input_path)

    impulse_n_s = trapezoidal_impulse(
        measurements["time_s"].to_numpy(),
        measurements["force_n"].to_numpy(),
    )

    mass_kg = 0.50
    delta_velocity_m_per_s = impulse_n_s / mass_kg

    summary = pd.DataFrame(
        [
            {
                "mass_kg": mass_kg,
                "impulse_n_s": impulse_n_s,
                "delta_velocity_m_per_s": delta_velocity_m_per_s,
                "delta_momentum_kg_m_per_s": impulse_n_s,
            }
        ]
    )

    summary.to_csv(output_path, index=False)

    print("Impulse-momentum summary:")
    print(summary.round(8).to_string(index=False))
    print(f"\nSaved summary to: {output_path}")


if __name__ == "__main__":
    main()
