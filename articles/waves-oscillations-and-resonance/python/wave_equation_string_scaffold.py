"""
Finite-Difference Wave Equation Scaffold

This workflow evolves a one-dimensional string wave:

    d2y/dt2 = v^2 d2y/dx2

with fixed-end boundary conditions.

It is a transparent teaching scaffold rather than a high-fidelity PDE solver.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Simulate a plucked string using an explicit finite-difference scheme.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_wave_equation_string_snapshots.csv"

    length_m = 1.0
    wave_speed_m_per_s = 100.0
    nx = 201
    dx = length_m / (nx - 1)
    dt = 0.000005
    nt = 1200

    courant = wave_speed_m_per_s * dt / dx

    if courant > 1.0:
        raise ValueError("Courant condition violated. Reduce dt or increase dx.")

    x = np.linspace(0.0, length_m, nx)

    y_previous = np.where(
        x <= 0.3,
        0.01 * x / 0.3,
        0.01 * (1.0 - x) / 0.7,
    )
    y_previous[0] = 0.0
    y_previous[-1] = 0.0

    y_current = y_previous.copy()

    snapshots = []

    for step in range(nt + 1):
        if step in [0, 100, 300, 600, 900, 1200]:
            for position_m, displacement_m in zip(x, y_current):
                snapshots.append(
                    {
                        "step": step,
                        "time_s": step * dt,
                        "position_m": position_m,
                        "displacement_m": displacement_m,
                    }
                )

        y_next = y_current.copy()
        y_next[1:-1] = (
            2.0 * y_current[1:-1]
            - y_previous[1:-1]
            + courant**2
            * (y_current[2:] - 2.0 * y_current[1:-1] + y_current[:-2])
        )

        y_next[0] = 0.0
        y_next[-1] = 0.0

        y_previous, y_current = y_current, y_next

    table = pd.DataFrame(snapshots)
    table.to_csv(output_path, index=False)

    print("Wave-equation scaffold snapshot sample:")
    print(table.head(12).round(8).to_string(index=False))
    print(f"\nSaved snapshots to: {output_path}")


if __name__ == "__main__":
    main()
