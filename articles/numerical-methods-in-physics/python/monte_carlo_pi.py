"""
Monte Carlo Estimate of Pi

Samples points uniformly in the unit square and estimates pi from the
fraction that lie inside the quarter unit circle.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> dict:
    """
    Estimate pi for one sample size.
    """
    n_samples = int(case["n_samples"])
    rng = np.random.default_rng(int(case["seed"]))

    x = rng.random(n_samples)
    y = rng.random(n_samples)

    inside = (x**2 + y**2) <= 1.0
    pi_estimate = 4.0 * inside.mean()

    # Bernoulli standard error propagated through the factor 4.
    p_hat = inside.mean()
    standard_error = 4.0 * np.sqrt(p_hat * (1.0 - p_hat) / n_samples)

    return {
        "case_id": case["case_id"],
        "n_samples": n_samples,
        "pi_estimate": pi_estimate,
        "absolute_error": abs(pi_estimate - np.pi),
        "standard_error_estimate": standard_error,
        "notes": case["notes"],
    }


def main() -> None:
    """
    Run Monte Carlo pi cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "monte_carlo_cases.csv")

    output = pd.DataFrame([run_case(case) for _, case in cases.iterrows()])
    output.to_csv(article_dir / "data" / "computed_monte_carlo_pi.csv", index=False)

    print("Monte Carlo pi estimates:")
    print(output.round(12).to_string(index=False))


if __name__ == "__main__":
    main()
