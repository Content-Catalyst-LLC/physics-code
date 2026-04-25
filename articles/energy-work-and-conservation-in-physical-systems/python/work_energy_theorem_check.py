"""
Work-Energy Theorem Check

This workflow integrates work from force-displacement data and compares it
with the kinetic-energy change predicted by the work-energy theorem.

For a spring-style force:
    F(x) = k x

Work from x = 0 to x = A:
    W = integral F dx = 1/2 k A^2

If this work becomes kinetic energy:
    W = Delta K = 1/2 m v^2
"""

from pathlib import Path

import numpy as np
import pandas as pd


def trapezoidal_work(displacement_m: np.ndarray, force_n: np.ndarray) -> float:
    """
    Compute work from force-displacement samples using trapezoidal integration.
    """
    return float(np.trapz(force_n, displacement_m))


def main() -> None:
    """
    Compare measured force-displacement work with theoretical spring work.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "force_displacement_measurements.csv"
    output_path = article_dir / "data" / "computed_work_energy_theorem_check.csv"

    measurements = pd.read_csv(input_path)

    work_numeric_j = trapezoidal_work(
        measurements["displacement_m"].to_numpy(),
        measurements["force_n"].to_numpy(),
    )

    mass_kg = 0.50
    final_speed_m_per_s = np.sqrt(2.0 * work_numeric_j / mass_kg)

    summary = pd.DataFrame(
        [
            {
                "numeric_work_j": work_numeric_j,
                "mass_kg": mass_kg,
                "predicted_final_speed_m_per_s": final_speed_m_per_s,
                "predicted_delta_kinetic_energy_j": 0.5 * mass_kg * final_speed_m_per_s**2,
            }
        ]
    )

    summary.to_csv(output_path, index=False)

    print("Work-energy theorem check:")
    print(summary.round(8).to_string(index=False))
    print(f"\nSaved summary to: {output_path}")


if __name__ == "__main__":
    main()
