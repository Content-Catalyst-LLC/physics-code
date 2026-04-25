"""
Inverse Diffusion Parameter Scaffold

Generates synthetic data from:

    u(x,t) = exp(-D*pi^2*t) sin(pi*x)

and estimates D by minimizing a squared-error objective over a grid.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> tuple[pd.DataFrame, dict]:
    """
    Generate data and estimate diffusion coefficient through grid search.
    """
    rng = np.random.default_rng(int(case["seed"]))

    true_diffusion = float(case["true_diffusion"])
    n_x = int(case["n_x"])
    n_t = int(case["n_t"])
    noise_sd = float(case["noise_sd"])

    x = np.linspace(0.0, 1.0, n_x)
    t = np.linspace(0.0, 1.0, n_t)

    xx, tt = np.meshgrid(x, t, indexing="ij")
    u_true = np.exp(-true_diffusion * np.pi**2 * tt) * np.sin(np.pi * xx)
    u_obs = u_true + rng.normal(0.0, noise_sd, size=u_true.shape)

    candidate_d = np.linspace(0.02, 0.5, 300)
    rows = []

    for d_value in candidate_d:
        u_model = np.exp(-d_value * np.pi**2 * tt) * np.sin(np.pi * xx)
        mse = float(np.mean((u_model - u_obs) ** 2))

        rows.append(
            {
                "case_id": case["case_id"],
                "candidate_diffusion": d_value,
                "mse": mse,
                "notes": case["notes"],
            }
        )

    objective_table = pd.DataFrame(rows)
    best_row = objective_table.loc[objective_table["mse"].idxmin()]

    summary = {
        "case_id": case["case_id"],
        "true_diffusion": true_diffusion,
        "estimated_diffusion": float(best_row["candidate_diffusion"]),
        "minimum_mse": float(best_row["mse"]),
        "noise_sd": noise_sd,
        "absolute_parameter_error": abs(float(best_row["candidate_diffusion"]) - true_diffusion),
        "notes": case["notes"],
    }

    return objective_table, summary


def main() -> None:
    """
    Run inverse diffusion parameter cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "inverse_diffusion_cases.csv")

    objective_tables = []
    summaries = []

    for _, case in cases.iterrows():
        objective_table, summary = run_case(case)
        objective_tables.append(objective_table)
        summaries.append(summary)

    objective_output = pd.concat(objective_tables, ignore_index=True)
    summary_output = pd.DataFrame(summaries)

    objective_output.to_csv(article_dir / "data" / "computed_inverse_diffusion_objective.csv", index=False)
    summary_output.to_csv(article_dir / "data" / "computed_inverse_diffusion_summary.csv", index=False)

    print("Inverse diffusion summary:")
    print(summary_output.round(10).to_string(index=False))


if __name__ == "__main__":
    main()
