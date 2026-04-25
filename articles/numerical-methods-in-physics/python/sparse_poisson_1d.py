"""
Sparse One-Dimensional Poisson Solver

Solves:

    -u''(x) = f(x)

on x in [0, L] with u(0)=u(L)=0.

For f(x) = A sin(pi x / L), the exact solution is:

    u(x) = A (L/pi)^2 sin(pi x / L)
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.sparse import diags
from scipy.sparse.linalg import spsolve


def solve_case(case: pd.Series) -> tuple[pd.DataFrame, dict]:
    """
    Solve one sparse Poisson case.
    """
    length = float(case["length"])
    n_grid = int(case["n_grid"])
    amplitude = float(case["source_amplitude"])

    x = np.linspace(0.0, length, n_grid)
    dx = x[1] - x[0]

    interior_x = x[1:-1]
    n_interior = len(interior_x)

    main_diag = 2.0 * np.ones(n_interior) / dx**2
    off_diag = -1.0 * np.ones(n_interior - 1) / dx**2

    matrix = diags(
        diagonals=[off_diag, main_diag, off_diag],
        offsets=[-1, 0, 1],
        format="csr",
    )

    source = amplitude * np.sin(np.pi * interior_x / length)
    interior_solution = spsolve(matrix, source)

    solution = np.zeros(n_grid)
    solution[1:-1] = interior_solution

    exact = amplitude * (length / np.pi) ** 2 * np.sin(np.pi * x / length)

    profile = pd.DataFrame(
        {
            "case_id": case["case_id"],
            "x": x,
            "numerical_solution": solution,
            "exact_solution": exact,
            "absolute_error": np.abs(solution - exact),
        }
    )

    summary = {
        "case_id": case["case_id"],
        "length": length,
        "n_grid": n_grid,
        "dx": dx,
        "max_absolute_error": float(np.max(np.abs(solution - exact))),
        "l2_error": float(np.sqrt(np.mean((solution - exact) ** 2))),
        "notes": case["notes"],
    }

    return profile, summary


def main() -> None:
    """
    Run sparse Poisson solver cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "poisson_cases.csv")

    profiles = []
    summaries = []

    for _, case in cases.iterrows():
        profile, summary = solve_case(case)
        profiles.append(profile)
        summaries.append(summary)

    profile_output = pd.concat(profiles, ignore_index=True)
    summary_output = pd.DataFrame(summaries)

    profile_output.to_csv(article_dir / "data" / "computed_sparse_poisson_profiles.csv", index=False)
    summary_output.to_csv(article_dir / "data" / "computed_sparse_poisson_summary.csv", index=False)

    print("Sparse Poisson summary:")
    print(summary_output.round(12).to_string(index=False))


if __name__ == "__main__":
    main()
