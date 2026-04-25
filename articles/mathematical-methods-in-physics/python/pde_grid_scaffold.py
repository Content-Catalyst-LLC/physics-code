"""
Finite-Difference PDE Grid Scaffold

This workflow builds a one-dimensional diffusion equation scaffold:

    partial u / partial t = D partial^2 u / partial x^2

using an explicit finite-difference method.

This is a teaching scaffold, not a production PDE solver.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Simulate diffusion of a Gaussian-like pulse.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_pde_diffusion_snapshots.csv"

    length_m = 1.0
    nx = 201
    x = np.linspace(0.0, length_m, nx)
    dx = x[1] - x[0]

    diffusivity_m2_per_s = 0.001
    dt = 0.0002
    nt = 1000

    stability_number = diffusivity_m2_per_s * dt / dx**2

    if stability_number > 0.5:
        raise ValueError("Explicit diffusion stability condition violated.")

    u = np.exp(-((x - 0.5) ** 2) / (2.0 * 0.04**2))

    snapshots = []

    for step in range(nt + 1):
        if step in [0, 100, 250, 500, 750, 1000]:
            for position, value in zip(x, u):
                snapshots.append(
                    {
                        "step": step,
                        "time_s": step * dt,
                        "position_m": position,
                        "field_value": value,
                    }
                )

        u_next = u.copy()
        u_next[1:-1] = (
            u[1:-1]
            + stability_number * (u[2:] - 2.0 * u[1:-1] + u[:-2])
        )
        u_next[0] = 0.0
        u_next[-1] = 0.0

        u = u_next

    table = pd.DataFrame(snapshots)
    table.to_csv(output_path, index=False)

    print("Diffusion scaffold sample:")
    print(table.head(12).round(8).to_string(index=False))
    print(f"\nSaved diffusion snapshots to: {output_path}")


if __name__ == "__main__":
    main()
