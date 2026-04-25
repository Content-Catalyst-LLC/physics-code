"""
Logistic Map Bifurcation Data

This workflow iterates:

    x_{n+1} = r x_n (1 - x_n)

across many r values, discards transients, and writes long-run states.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def iterate_logistic_map(
    r: float,
    x0: float = 0.2,
    n_iter: int = 1200,
    burn_in: int = 800,
) -> pd.DataFrame:
    """
    Iterate the logistic map and return post-transient values.
    """
    x = np.empty(n_iter)
    x[0] = x0

    for i in range(1, n_iter):
        x[i] = r * x[i - 1] * (1.0 - x[i - 1])

    iteration = np.arange(1, n_iter + 1)

    return pd.DataFrame(
        {
            "iteration": iteration[iteration > burn_in],
            "r": r,
            "x": x[iteration > burn_in],
        }
    )


def main() -> None:
    """
    Generate bifurcation data and summary diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_logistic_bifurcation_data.csv"
    summary_path = article_dir / "data" / "computed_logistic_bifurcation_summary.csv"

    r_values = np.arange(2.5, 4.0001, 0.005)

    frames = [
        iterate_logistic_map(float(r_value))
        for r_value in r_values
    ]

    bifurcation_data = pd.concat(frames, ignore_index=True)

    summary = (
        bifurcation_data
        .groupby("r", as_index=False)
        .agg(
            min_x=("x", "min"),
            mean_x=("x", "mean"),
            max_x=("x", "max"),
            sd_x=("x", "std"),
            approximate_unique_states=("x", lambda values: len(set(np.round(values, 5)))),
        )
    )

    def classify_region(r: float) -> str:
        if r < 3.0:
            return "stable_fixed_point"
        if r < 3.45:
            return "period_doubling_region"
        if r < 3.57:
            return "higher_period_region"
        return "chaotic_or_mixed_region"

    summary["qualitative_region"] = summary["r"].apply(classify_region)

    bifurcation_data.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Bifurcation data sample:")
    print(bifurcation_data.head(12).round(8).to_string(index=False))

    print("\nBifurcation summary sample:")
    print(summary.head(12).round(8).to_string(index=False))

    print(f"\nSaved bifurcation data to: {output_path}")
    print(f"Saved summary to: {summary_path}")


if __name__ == "__main__":
    main()
