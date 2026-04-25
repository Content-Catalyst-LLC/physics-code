"""
Stochastic Path Scaffold

This workflow simulates simple drift-diffusion paths:

    x[n+1] = x[n] + drift * dt + noise_sd * sqrt(dt) * eta[n]

where eta[n] is standard normal noise.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Simulate one stochastic path case.
    """
    rng = np.random.default_rng(int(case["random_seed"]))

    n_steps = int(case["n_steps"])
    delta_t = float(case["delta_t"])
    drift = float(case["drift"])
    noise_sd = float(case["noise_sd"])

    increments = drift * delta_t + noise_sd * np.sqrt(delta_t) * rng.normal(size=n_steps)
    path = np.cumsum(np.insert(increments, 0, 0.0))

    return pd.DataFrame(
        {
            "case_id": case["case_id"],
            "step": np.arange(n_steps + 1),
            "time": np.arange(n_steps + 1) * delta_t,
            "x": path,
            "drift": drift,
            "noise_sd": noise_sd,
            "notes": case["notes"],
        }
    )


def main() -> None:
    """
    Simulate configured stochastic paths and summarize them.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "stochastic_path_cases.csv"
    output_path = article_dir / "data" / "computed_stochastic_paths.csv"
    summary_path = article_dir / "data" / "computed_stochastic_path_summary.csv"

    cases = pd.read_csv(input_path)
    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)

    summary = (
        output.groupby("case_id", as_index=False)
        .agg(
            final_x=("x", "last"),
            mean_x=("x", "mean"),
            sd_x=("x", "std"),
            min_x=("x", "min"),
            max_x=("x", "max"),
        )
    )

    output.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Stochastic path summary:")
    print(summary.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
