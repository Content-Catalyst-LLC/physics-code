"""
Heat Equation Residual Diagnostics

Evaluates the residual:

    r(x,t) = u_t - D u_xx

for the manufactured heat-equation solution:

    u(x,t) = exp(-D*pi^2*t) * sin(pi*x)

The exact residual is zero. The numerical residual is nonzero because
derivatives are approximated on a finite grid.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> tuple[pd.DataFrame, dict]:
    """
    Compute finite-difference residual diagnostics for one heat-equation case.
    """
    diffusion = float(case["diffusion"])
    n_x = int(case["n_x"])
    n_t = int(case["n_t"])

    x = np.linspace(0.0, 1.0, n_x)
    t = np.linspace(0.0, 1.0, n_t)

    dx = x[1] - x[0]
    dt = t[1] - t[0]

    xx, tt = np.meshgrid(x, t, indexing="ij")
    u = np.exp(-diffusion * np.pi**2 * tt) * np.sin(np.pi * xx)

    residual_rows = []

    for i in range(1, n_x - 1):
        for j in range(1, n_t - 1):
            u_t = (u[i, j + 1] - u[i, j - 1]) / (2.0 * dt)
            u_xx = (u[i + 1, j] - 2.0 * u[i, j] + u[i - 1, j]) / dx**2
            residual = u_t - diffusion * u_xx

            residual_rows.append(
                {
                    "case_id": case["case_id"],
                    "x": x[i],
                    "t": t[j],
                    "u": u[i, j],
                    "u_t": u_t,
                    "u_xx": u_xx,
                    "residual": residual,
                    "residual_squared": residual**2,
                    "notes": case["notes"],
                }
            )

    residual_table = pd.DataFrame(residual_rows)

    summary = {
        "case_id": case["case_id"],
        "diffusion": diffusion,
        "n_x": n_x,
        "n_t": n_t,
        "dx": dx,
        "dt": dt,
        "mean_absolute_residual": float(np.mean(np.abs(residual_table["residual"]))),
        "root_mean_squared_residual": float(np.sqrt(np.mean(residual_table["residual_squared"]))),
        "max_absolute_residual": float(np.max(np.abs(residual_table["residual"]))),
        "notes": case["notes"],
    }

    return residual_table, summary


def main() -> None:
    """
    Run all configured heat-equation residual cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "heat_residual_cases.csv")

    residual_tables = []
    summaries = []

    for _, case in cases.iterrows():
        residual_table, summary = run_case(case)
        residual_tables.append(residual_table)
        summaries.append(summary)

    residual_output = pd.concat(residual_tables, ignore_index=True)
    summary_output = pd.DataFrame(summaries)

    residual_output.to_csv(article_dir / "data" / "computed_heat_residual_table.csv", index=False)
    summary_output.to_csv(article_dir / "data" / "computed_heat_residual_summary.csv", index=False)

    print("Heat residual diagnostics:")
    print(summary_output.round(12).to_string(index=False))


if __name__ == "__main__":
    main()
