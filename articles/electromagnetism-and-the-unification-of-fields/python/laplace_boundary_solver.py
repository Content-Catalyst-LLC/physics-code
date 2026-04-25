"""
Finite-Difference Laplace Boundary Solver

This workflow solves a simple two-dimensional Laplace equation scaffold:

    del^2 V = 0

on a square grid with fixed boundary potentials.

This is an educational finite-difference relaxation example, not a production
finite-element electromagnetics solver.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def solve_laplace(
    n_grid: int = 80,
    top_voltage_v: float = 1.0,
    bottom_voltage_v: float = 0.0,
    left_voltage_v: float = 0.0,
    right_voltage_v: float = 0.0,
    n_iterations: int = 4000,
) -> np.ndarray:
    """
    Solve a simple Laplace equation problem by Jacobi relaxation.
    """
    potential = np.zeros((n_grid, n_grid), dtype=float)

    potential[0, :] = top_voltage_v
    potential[-1, :] = bottom_voltage_v
    potential[:, 0] = left_voltage_v
    potential[:, -1] = right_voltage_v

    for _ in range(n_iterations):
        updated = potential.copy()
        updated[1:-1, 1:-1] = 0.25 * (
            potential[0:-2, 1:-1]
            + potential[2:, 1:-1]
            + potential[1:-1, 0:-2]
            + potential[1:-1, 2:]
        )

        potential = updated
        potential[0, :] = top_voltage_v
        potential[-1, :] = bottom_voltage_v
        potential[:, 0] = left_voltage_v
        potential[:, -1] = right_voltage_v

    return potential


def main() -> None:
    """
    Solve and summarize a finite-difference Laplace scaffold.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_laplace_boundary_summary.csv"

    potential = solve_laplace()

    d_v_dy, d_v_dx = np.gradient(potential)
    electric_field_x = -d_v_dx
    electric_field_y = -d_v_dy
    field_magnitude = np.sqrt(electric_field_x**2 + electric_field_y**2)

    summary = pd.DataFrame(
        [
            {
                "n_grid": potential.shape[0],
                "potential_min_v": float(np.min(potential)),
                "potential_max_v": float(np.max(potential)),
                "field_magnitude_mean_grid_units": float(np.mean(field_magnitude)),
                "field_magnitude_max_grid_units": float(np.max(field_magnitude)),
            }
        ]
    )

    summary.to_csv(output_path, index=False)

    print("Laplace boundary-value summary:")
    print(summary.to_string(index=False))
    print(f"\nSaved summary to: {output_path}")


if __name__ == "__main__":
    main()
