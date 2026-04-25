"""
One-Dimensional Advection-Diffusion Scaffold

This workflow evolves a passive scalar c(x,t):

    partial c / partial t + u partial c / partial x = D partial^2 c / partial x^2

using a simple explicit finite-difference scheme.

This is a transparent teaching scaffold, not a production transport solver.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Simulate advection-diffusion of an initial scalar pulse.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_advection_diffusion_snapshots.csv"

    length_m = 1.0
    nx = 301
    x = np.linspace(0.0, length_m, nx)
    dx = x[1] - x[0]

    velocity_m_per_s = 0.25
    diffusivity_m2_per_s = 0.002

    dt = 0.0005
    nt = 1600

    courant = velocity_m_per_s * dt / dx
    diffusion_number = diffusivity_m2_per_s * dt / dx**2

    if courant > 1.0:
        raise ValueError("Courant condition is too large.")
    if diffusion_number > 0.5:
        raise ValueError("Diffusion stability condition is too large.")

    concentration = np.exp(-((x - 0.25) ** 2) / (2.0 * 0.02**2))

    snapshots = []

    for step in range(nt + 1):
        if step in [0, 200, 400, 800, 1200, 1600]:
            for position_m, value in zip(x, concentration):
                snapshots.append(
                    {
                        "step": step,
                        "time_s": step * dt,
                        "position_m": position_m,
                        "concentration": value,
                    }
                )

        next_concentration = concentration.copy()

        next_concentration[1:-1] = (
            concentration[1:-1]
            - courant * (concentration[1:-1] - concentration[:-2])
            + diffusion_number * (
                concentration[2:]
                - 2.0 * concentration[1:-1]
                + concentration[:-2]
            )
        )

        next_concentration[0] = 0.0
        next_concentration[-1] = 0.0

        concentration = next_concentration

    table = pd.DataFrame(snapshots)
    table.to_csv(output_path, index=False)

    print("Advection-diffusion scaffold sample:")
    print(table.head(12).round(8).to_string(index=False))
    print(f"\nSaved snapshots to: {output_path}")


if __name__ == "__main__":
    main()
