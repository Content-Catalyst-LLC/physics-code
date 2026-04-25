"""
Explicit FTCS Solver for the One-Dimensional Heat Equation

Equation:

    partial u / partial t = D partial^2 u / partial x^2

Update:

    u_i^{n+1} = u_i^n + r (u_{i+1}^n - 2u_i^n + u_{i-1}^n)

where:

    r = D dt / dx^2

The standard one-dimensional explicit stability condition is:

    r <= 1/2
"""

from pathlib import Path

import numpy as np
import pandas as pd


def simulate_case(case: pd.Series) -> tuple[pd.DataFrame, pd.DataFrame]:
    """
    Simulate a heat-equation case and return diagnostics plus final profile.
    """
    diffusion = float(case["diffusion_coefficient"])
    length = float(case["length"])
    n_grid = int(case["n_grid"])
    time_step = float(case["time_step"])
    n_steps = int(case["n_steps"])

    x = np.linspace(0.0, length, n_grid)
    dx = x[1] - x[0]
    r = diffusion * time_step / dx**2

    center = 0.5 * length
    width = 0.08 * length
    u = np.exp(-0.5 * ((x - center) / width) ** 2)

    u[0] = 0.0
    u[-1] = 0.0

    diagnostic_rows = []

    for step in range(n_steps + 1):
        if step % max(1, n_steps // 25) == 0:
            diagnostic_rows.append(
                {
                    "case_id": case["case_id"],
                    "step": step,
                    "time": step * time_step,
                    "dx": dx,
                    "dt": time_step,
                    "stability_number": r,
                    "stable_by_standard_condition": r <= 0.5,
                    "max_u": float(np.max(u)),
                    "min_u": float(np.min(u)),
                    "integral_u": float(np.trapz(u, x)),
                    "notes": case["notes"],
                }
            )

        u_next = u.copy()
        u_next[1:-1] = u[1:-1] + r * (u[2:] - 2.0 * u[1:-1] + u[:-2])
        u_next[0] = 0.0
        u_next[-1] = 0.0
        u = u_next

    diagnostics = pd.DataFrame(diagnostic_rows)
    final_profile = pd.DataFrame({"case_id": case["case_id"], "x": x, "u_final": u})

    return diagnostics, final_profile


def main() -> None:
    """
    Run all configured heat-equation cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "heat_equation_cases.csv")

    diagnostics_list = []
    final_profiles = []

    for _, case in cases.iterrows():
        diagnostics, profile = simulate_case(case)
        diagnostics_list.append(diagnostics)
        final_profiles.append(profile)

    diagnostics_output = pd.concat(diagnostics_list, ignore_index=True)
    profile_output = pd.concat(final_profiles, ignore_index=True)

    diagnostics_output.to_csv(article_dir / "data" / "computed_heat_equation_diagnostics.csv", index=False)
    profile_output.to_csv(article_dir / "data" / "computed_heat_equation_final_profiles.csv", index=False)

    print("Heat-equation diagnostics:")
    print(diagnostics_output.groupby("case_id").tail(3).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
