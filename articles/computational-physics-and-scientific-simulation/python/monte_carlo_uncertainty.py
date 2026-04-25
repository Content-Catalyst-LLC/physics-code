"""
Monte Carlo Uncertainty Propagation for Projectile Range

Ideal model:

    R = v^2 sin(2 theta) / g

The model ignores air resistance and assumes equal launch/landing height.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Run a Monte Carlo uncertainty propagation workflow.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_monte_carlo_projectile_samples.csv"
    summary_path = article_dir / "data" / "computed_monte_carlo_projectile_summary.csv"

    rng = np.random.default_rng(42)

    n_samples = 10000
    gravity = 9.80665

    speed = rng.normal(loc=30.0, scale=1.5, size=n_samples)
    angle_deg = rng.normal(loc=45.0, scale=2.0, size=n_samples)
    angle_rad = np.deg2rad(angle_deg)

    range_m = speed**2 * np.sin(2.0 * angle_rad) / gravity

    samples = pd.DataFrame(
        {
            "sample_id": np.arange(1, n_samples + 1),
            "launch_speed_m_per_s": speed,
            "launch_angle_deg": angle_deg,
            "launch_angle_rad": angle_rad,
            "range_m": range_m,
        }
    )

    summary = pd.DataFrame(
        [
            {
                "samples": n_samples,
                "mean_range_m": np.mean(range_m),
                "sd_range_m": np.std(range_m, ddof=1),
                "p05_range_m": np.quantile(range_m, 0.05),
                "median_range_m": np.quantile(range_m, 0.50),
                "p95_range_m": np.quantile(range_m, 0.95),
                "min_range_m": np.min(range_m),
                "max_range_m": np.max(range_m),
            }
        ]
    )

    samples.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Monte Carlo sample:")
    print(samples.head(12).round(8).to_string(index=False))
    print("\nSummary:")
    print(summary.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
