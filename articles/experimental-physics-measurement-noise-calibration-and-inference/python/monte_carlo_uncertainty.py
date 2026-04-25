"""
Monte Carlo Uncertainty Propagation

This workflow propagates uncertainty for:

    R = V / I

by sampling V and I from normal distributions.
"""

from pathlib import Path

import numpy as np
import pandas as pd


RANDOM_SEED = 123
N_SAMPLES = 100000


def main() -> None:
    """
    Run Monte Carlo uncertainty propagation for resistance.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_monte_carlo_resistance_uncertainty.csv"

    rng = np.random.default_rng(RANDOM_SEED)

    voltage_samples = rng.normal(loc=10.00, scale=0.02, size=N_SAMPLES)
    current_samples = rng.normal(loc=2.000, scale=0.005, size=N_SAMPLES)

    resistance_samples = voltage_samples / current_samples

    summary = pd.DataFrame(
        [
            {
                "n_samples": N_SAMPLES,
                "resistance_mean_ohm": np.mean(resistance_samples),
                "resistance_sd_ohm": np.std(resistance_samples, ddof=1),
                "resistance_median_ohm": np.median(resistance_samples),
                "resistance_q025_ohm": np.quantile(resistance_samples, 0.025),
                "resistance_q975_ohm": np.quantile(resistance_samples, 0.975),
            }
        ]
    )

    summary.to_csv(output_path, index=False)

    print("Monte Carlo resistance uncertainty:")
    print(summary.round(10).to_string(index=False))


if __name__ == "__main__":
    main()
