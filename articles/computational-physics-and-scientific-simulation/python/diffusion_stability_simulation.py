"""
Diffusion Simulation with Stability Diagnostics

This workflow solves the one-dimensional diffusion equation:

    partial u / partial t = D partial^2 u / partial x^2

using an explicit finite-difference method:

    u_i^{n+1} = u_i^n + s (u_{i+1}^n - 2u_i^n + u_{i-1}^n)

where:

    s = D dt / dx^2

For the standard explicit one-dimensional diffusion method, stability requires:

    s <= 1/2
"""

from pathlib import Path

import numpy as np
import pandas as pd


LENGTH_M = 1.0
N_GRID = 201
DIFFUSIVITY_M2_PER_S = 0.001
TIME_STEP_S = 0.0002
N_STEPS = 1200


def main() -> None:
    """
    Run a finite-difference diffusion simulation and save diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    snapshot_path = article_dir / "data" / "computed_diffusion_snapshots.csv"
    diagnostic_path = article_dir / "data" / "computed_diffusion_diagnostics.csv"

    x = np.linspace(0.0, LENGTH_M, N_GRID)
    dx = x[1] - x[0]

    stability_number = DIFFUSIVITY_M2_PER_S * TIME_STEP_S / dx**2

    if stability_number > 0.5:
        raise ValueError(
            "The explicit diffusion method is unstable because "
            f"D dt / dx^2 = {stability_number:.4f} > 0.5"
        )

    field = np.exp(-((x - 0.5) ** 2) / (2.0 * 0.04**2))

    snapshots = []
    diagnostics = []

    for step in range(N_STEPS + 1):
        time_s = step * TIME_STEP_S

        if step in [0, 100, 300, 600, 900, 1200]:
            for position_m, value in zip(x, field):
                snapshots.append(
                    {
                        "step": step,
                        "time_s": time_s,
                        "position_m": position_m,
                        "field_value": value,
                    }
                )

        diagnostics.append(
            {
                "step": step,
                "time_s": time_s,
                "dx_m": dx,
                "time_step_s": TIME_STEP_S,
                "stability_number": float(stability_number),
                "total_field_integral": float(np.trapz(field, x)),
                "max_field_value": float(np.max(field)),
                "min_field_value": float(np.min(field)),
            }
        )

        next_field = field.copy()
        next_field[1:-1] = (
            field[1:-1]
            + stability_number
            * (field[2:] - 2.0 * field[1:-1] + field[:-2])
        )

        next_field[0] = 0.0
        next_field[-1] = 0.0

        field = next_field

    snapshot_table = pd.DataFrame(snapshots)
    diagnostic_table = pd.DataFrame(diagnostics)

    snapshot_table.to_csv(snapshot_path, index=False)
    diagnostic_table.to_csv(diagnostic_path, index=False)

    print("Diffusion snapshots:")
    print(snapshot_table.head(12).round(8).to_string(index=False))

    print("\nSimulation diagnostics:")
    print(diagnostic_table.iloc[::300, :].round(8).to_string(index=False))

    print(f"\nSaved snapshots to: {snapshot_path}")
    print(f"Saved diagnostics to: {diagnostic_path}")


if __name__ == "__main__":
    main()
