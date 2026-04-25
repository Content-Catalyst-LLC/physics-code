"""
Bayesian Measurement Update

This workflow performs a normal-normal Bayesian update.

Prior:
    theta ~ Normal(mu0, sigma0^2)

Measurements:
    x_i ~ Normal(theta, sigma^2)

Posterior:
    theta | x ~ Normal(mu_n, sigma_n^2)
"""

from pathlib import Path

import numpy as np
import pandas as pd


def normal_normal_update(
    prior_mean: float,
    prior_sd: float,
    observations: np.ndarray,
    observation_sd: float,
) -> dict:
    """
    Compute posterior parameters for normal prior and normal likelihood.
    """
    prior_precision = 1.0 / prior_sd**2
    data_precision = len(observations) / observation_sd**2

    posterior_variance = 1.0 / (prior_precision + data_precision)

    posterior_mean = posterior_variance * (
        prior_mean * prior_precision
        + np.sum(observations) / observation_sd**2
    )

    return {
        "prior_mean": prior_mean,
        "prior_sd": prior_sd,
        "observation_mean": np.mean(observations),
        "observation_sd_assumed": observation_sd,
        "n_observations": len(observations),
        "posterior_mean": posterior_mean,
        "posterior_sd": np.sqrt(posterior_variance),
    }


def main() -> None:
    """
    Run a simple Bayesian update for repeated measurements.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_bayesian_measurement_update.csv"

    observations = np.array([9.98, 10.01, 10.00, 10.03, 9.99, 10.02])

    summary = pd.DataFrame(
        [
            normal_normal_update(
                prior_mean=10.00,
                prior_sd=0.05,
                observations=observations,
                observation_sd=0.02,
            )
        ]
    )

    summary.to_csv(output_path, index=False)

    print("Bayesian measurement update:")
    print(summary.round(10).to_string(index=False))


if __name__ == "__main__":
    main()
