"""
Conservation Diagnostics Scaffold

Tracks a simple mass-like integral over an advected periodic field.

This is a diagnostic scaffold for evaluating whether a learned or numerical
model preserves a conserved quantity.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Compute conservation diagnostics for periodic advection.
    """
    n_grid = int(case["n_grid"])
    velocity = float(case["velocity"])
    dt = float(case["time_step"])
    n_steps = int(case["n_steps"])

    x = np.linspace(0.0, 1.0, n_grid, endpoint=False)
    dx = x[1] - x[0]

    u = 1.0 + 0.2 * np.sin(2.0 * np.pi * x)
    mass_initial = float(np.sum(u) * dx)

    rows = []

    for step in range(n_steps + 1):
        mass = float(np.sum(u) * dx)

        rows.append(
            {
                "case_id": case["case_id"],
                "step": step,
                "time": step * dt,
                "mass": mass,
                "mass_initial": mass_initial,
                "mass_error": mass - mass_initial,
                "relative_mass_error": (mass - mass_initial) / mass_initial,
                "notes": case["notes"],
            }
        )

        # Periodic first-order upwind advection update.
        cfl = velocity * dt / dx
        u = u - cfl * (u - np.roll(u, 1))

    return pd.DataFrame(rows)


def main() -> None:
    """
    Run conservation diagnostic cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "conservation_cases.csv")

    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)
    summary = (
        output.groupby("case_id", as_index=False)
        .agg(
            max_absolute_mass_error=("mass_error", lambda x: float(np.max(np.abs(x)))),
            final_relative_mass_error=("relative_mass_error", "last"),
        )
    )

    output.to_csv(article_dir / "data" / "computed_conservation_diagnostics.csv", index=False)
    summary.to_csv(article_dir / "data" / "computed_conservation_summary.csv", index=False)

    print("Conservation diagnostic summary:")
    print(summary.round(12).to_string(index=False))


if __name__ == "__main__":
    main()
