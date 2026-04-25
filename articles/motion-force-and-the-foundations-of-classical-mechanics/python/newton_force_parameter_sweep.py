"""
Newtonian Force Parameter Sweep

This workflow applies Newton's second law:

    F_net = m a

to compute acceleration across masses and forces. It also computes the
distance traveled from rest under constant acceleration:

    x = 1/2 a t^2
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Generate a force-mass-acceleration parameter sweep.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_newton_force_parameter_sweep.csv"

    masses_kg = np.array([0.25, 0.50, 1.00, 2.00])
    forces_n = np.array([1.0, 2.0, 5.0, 10.0])
    duration_s = 2.0

    rows = []

    for mass_kg in masses_kg:
        for force_n in forces_n:
            acceleration_m_per_s2 = force_n / mass_kg
            final_velocity_m_per_s = acceleration_m_per_s2 * duration_s
            displacement_m = 0.5 * acceleration_m_per_s2 * duration_s**2

            rows.append(
                {
                    "mass_kg": mass_kg,
                    "net_force_n": force_n,
                    "duration_s": duration_s,
                    "acceleration_m_per_s2": acceleration_m_per_s2,
                    "final_velocity_m_per_s": final_velocity_m_per_s,
                    "displacement_m": displacement_m,
                }
            )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Newtonian force parameter sweep:")
    print(table.round(8).to_string(index=False))
    print(f"\nSaved parameter sweep to: {output_path}")


if __name__ == "__main__":
    main()
