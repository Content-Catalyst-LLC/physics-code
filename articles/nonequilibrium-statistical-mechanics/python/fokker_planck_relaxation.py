"""
Fokker-Planck Relaxation Scaffold

Evolves a one-dimensional probability density under:

    partial_t P = -partial_x[mu F P] + D partial_x^2 P

with harmonic force:

    F(x) = -k x

This is an explicit finite-difference teaching scaffold.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Run one explicit Fokker-Planck relaxation case.
    """
    domain_min = float(case["domain_min"])
    domain_max = float(case["domain_max"])
    n_grid = int(case["n_grid"])
    time_step = float(case["time_step"])
    n_steps = int(case["n_steps"])
    diffusion = float(case["diffusion"])
    mobility = float(case["mobility"])
    spring_constant = float(case["spring_constant"])

    x = np.linspace(domain_min, domain_max, n_grid)
    dx = x[1] - x[0]

    # Initial probability density: narrow Gaussian away from center.
    p = np.exp(-0.5 * ((x - 2.0) / 0.35) ** 2)
    p /= np.trapz(p, x)

    snapshots = []

    for step in range(n_steps + 1):
        if step % max(1, n_steps // 20) == 0:
            mean = np.trapz(x * p, x)
            variance = np.trapz((x - mean) ** 2 * p, x)
            snapshots.append(
                {
                    "case_id": case["case_id"],
                    "step": step,
                    "time": step * time_step,
                    "mean_position": mean,
                    "variance": variance,
                    "normalization": np.trapz(p, x),
                    "notes": case["notes"],
                }
            )

        force = -spring_constant * x

        # Probability current J = mu F P - D dP/dx.
        dpdx = np.gradient(p, dx)
        current = mobility * force * p - diffusion * dpdx

        # Conservation law: dP/dt = -dJ/dx.
        dcurrent_dx = np.gradient(current, dx)
        p = p - time_step * dcurrent_dx

        # Reflecting boundary approximation and positivity cleanup.
        p = np.maximum(p, 0.0)
        p /= np.trapz(p, x)

    return pd.DataFrame(snapshots)


def main() -> None:
    """
    Run all configured Fokker-Planck cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "fokker_planck_cases.csv")

    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)
    output.to_csv(article_dir / "data" / "computed_fokker_planck_relaxation.csv", index=False)

    print("Fokker-Planck relaxation summary:")
    print(output.groupby("case_id").tail(3).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
