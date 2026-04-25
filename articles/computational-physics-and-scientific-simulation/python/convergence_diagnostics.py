"""
Convergence Diagnostics for Explicit Diffusion

This workflow compares diffusion simulations at multiple grid resolutions
against the finest-grid result interpolated to coarser grids.

It is a teaching scaffold for grid refinement, not a formal validation study.
"""

from pathlib import Path

import numpy as np
import pandas as pd


DIFFUSIVITY = 0.001
LENGTH = 1.0
FINAL_TIME = 0.02


def run_diffusion(n_grid: int) -> tuple[np.ndarray, np.ndarray]:
    """
    Run a stable diffusion simulation for a given grid size.
    """
    x = np.linspace(0.0, LENGTH, n_grid)
    dx = x[1] - x[0]

    dt = 0.25 * dx**2 / DIFFUSIVITY
    n_steps = int(np.ceil(FINAL_TIME / dt))
    dt = FINAL_TIME / n_steps

    s = DIFFUSIVITY * dt / dx**2

    field = np.exp(-((x - 0.5) ** 2) / (2.0 * 0.04**2))

    for _ in range(n_steps):
        next_field = field.copy()
        next_field[1:-1] = (
            field[1:-1] + s * (field[2:] - 2.0 * field[1:-1] + field[:-2])
        )
        next_field[0] = 0.0
        next_field[-1] = 0.0
        field = next_field

    return x, field


def main() -> None:
    """
    Run grid-refinement diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_convergence_diagnostics.csv"

    grid_sizes = [51, 101, 201, 401]
    solutions = {}

    for n in grid_sizes:
        solutions[n] = run_diffusion(n)

    x_reference, field_reference = solutions[401]

    rows = []

    for n in grid_sizes[:-1]:
        x, field = solutions[n]
        reference_on_grid = np.interp(x, x_reference, field_reference)
        error = field - reference_on_grid

        rows.append(
            {
                "n_grid": n,
                "dx_m": x[1] - x[0],
                "l2_error_vs_finest": float(np.sqrt(np.mean(error**2))),
                "linf_error_vs_finest": float(np.max(np.abs(error))),
            }
        )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Grid-refinement diagnostics:")
    print(table.round(12).to_string(index=False))
    print(f"\nSaved convergence table to: {output_path}")


if __name__ == "__main__":
    main()
