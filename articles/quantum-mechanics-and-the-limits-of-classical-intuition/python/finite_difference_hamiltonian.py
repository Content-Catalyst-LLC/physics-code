"""
Finite-Difference Hamiltonian for a One-Dimensional Infinite Square Well

This workflow constructs a finite-difference approximation to:

    H = -hbar^2/(2m) d^2/dx^2

inside a one-dimensional infinite square well.

It compares numerical eigenvalues with analytic particle-in-a-box energies.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.linalg import eigh_tridiagonal


HBAR_J_S = 1.054_571_817e-34
ELECTRON_MASS_KG = 9.109_383_7015e-31
JOULE_PER_EV = 1.602_176_634e-19


def analytic_energy_j(n: int, mass_kg: float, box_length_m: float) -> float:
    """
    Compute analytic infinite-square-well energy.
    """
    return n**2 * np.pi**2 * HBAR_J_S**2 / (2.0 * mass_kg * box_length_m**2)


def main() -> None:
    """
    Build a finite-difference Hamiltonian and compare eigenvalues.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_finite_difference_eigenvalues.csv"

    box_length_m = 1.0e-9
    interior_points = 500
    dx_m = box_length_m / (interior_points + 1)

    coefficient = HBAR_J_S**2 / (2.0 * ELECTRON_MASS_KG * dx_m**2)

    diagonal = np.full(interior_points, 2.0 * coefficient)
    off_diagonal = np.full(interior_points - 1, -coefficient)

    eigenvalues_j, _ = eigh_tridiagonal(diagonal, off_diagonal)

    rows = []

    for n in range(1, 6):
        numerical_j = float(eigenvalues_j[n - 1])
        analytic_j = analytic_energy_j(n, ELECTRON_MASS_KG, box_length_m)

        rows.append(
            {
                "n": n,
                "numerical_energy_ev": numerical_j / JOULE_PER_EV,
                "analytic_energy_ev": analytic_j / JOULE_PER_EV,
                "relative_error": (numerical_j - analytic_j) / analytic_j,
            }
        )

    comparison = pd.DataFrame(rows)
    comparison.to_csv(output_path, index=False)

    print("Finite-difference Hamiltonian comparison:")
    print(comparison.to_string(index=False))
    print(f"\nSaved comparison to: {output_path}")


if __name__ == "__main__":
    main()
