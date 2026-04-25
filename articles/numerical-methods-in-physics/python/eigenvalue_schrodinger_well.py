"""
Finite Difference Eigenvalue Problem for an Infinite Square Well

Solves a dimensionless Schrödinger operator:

    H psi = E psi

with:

    H = -d^2/dx^2

on [0, L] with psi(0)=psi(L)=0.

Exact eigenvalues for this dimensionless operator are:

    E_n = (n pi / L)^2
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.sparse import diags
from scipy.sparse.linalg import eigsh


def solve_case(case: pd.Series) -> pd.DataFrame:
    """
    Solve one finite difference eigenvalue case.
    """
    length = float(case["length"])
    n_grid = int(case["n_grid"])
    n_eigenvalues = int(case["n_eigenvalues"])

    x = np.linspace(0.0, length, n_grid)
    dx = x[1] - x[0]

    n_interior = n_grid - 2

    main_diag = 2.0 * np.ones(n_interior) / dx**2
    off_diag = -1.0 * np.ones(n_interior - 1) / dx**2

    hamiltonian = diags(
        diagonals=[off_diag, main_diag, off_diag],
        offsets=[-1, 0, 1],
        format="csr",
    )

    eigenvalues, _ = eigsh(
        hamiltonian,
        k=n_eigenvalues,
        which="SM",
    )

    eigenvalues = np.sort(eigenvalues)
    n_values = np.arange(1, n_eigenvalues + 1)
    exact = (n_values * np.pi / length) ** 2

    return pd.DataFrame(
        {
            "case_id": case["case_id"],
            "n": n_values,
            "n_grid": n_grid,
            "length": length,
            "dx": dx,
            "numeric_eigenvalue": eigenvalues,
            "exact_eigenvalue": exact,
            "absolute_error": np.abs(eigenvalues - exact),
            "relative_error": np.abs(eigenvalues - exact) / exact,
            "notes": case["notes"],
        }
    )


def main() -> None:
    """
    Run all eigenvalue cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "eigenvalue_cases.csv")

    output = pd.concat([solve_case(case) for _, case in cases.iterrows()], ignore_index=True)
    output.to_csv(article_dir / "data" / "computed_schrodinger_well_eigenvalues.csv", index=False)

    print("Schrödinger well eigenvalue estimates:")
    print(output.round(12).to_string(index=False))


if __name__ == "__main__":
    main()
