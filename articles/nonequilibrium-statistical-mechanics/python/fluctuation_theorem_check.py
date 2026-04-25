"""
Fluctuation Theorem Check

Generates synthetic entropy-production samples and compares the empirical
ratio P(Sigma)/P(-Sigma) with exp(Sigma) in a simple Gaussian scaffold.

This is a teaching diagnostic, not a proof or a substitute for trajectory-level
thermodynamic modeling.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Generate a simple fluctuation-ratio table.
    """
    rng = np.random.default_rng(int(case["seed"]))

    samples = rng.normal(
        loc=float(case["entropy_mean"]),
        scale=float(case["entropy_sd"]),
        size=int(case["n_samples"]),
    )

    bins = np.linspace(0.1, 4.0, 30)
    rows = []

    width = 0.1
    for sigma in bins:
        positive = np.mean((samples > sigma - width) & (samples < sigma + width))
        negative = np.mean((samples > -sigma - width) & (samples < -sigma + width))

        ratio = positive / negative if negative > 0 else np.nan

        rows.append(
            {
                "case_id": case["case_id"],
                "sigma": sigma,
                "empirical_ratio": ratio,
                "exp_sigma": np.exp(sigma),
                "log_ratio": np.log(ratio) if ratio > 0 else np.nan,
                "notes": case["notes"],
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Run synthetic fluctuation-ratio checks.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "fluctuation_theorem_cases.csv")

    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)
    output.to_csv(article_dir / "data" / "computed_fluctuation_theorem_check.csv", index=False)

    print("Fluctuation theorem scaffold sample:")
    print(output.groupby("case_id").head(5).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
