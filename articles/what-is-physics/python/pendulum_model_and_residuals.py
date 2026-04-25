"""
Pendulum Modeling and Residual Analysis

This workflow demonstrates a common computational physics pattern:

1. Load measured data.
2. Define a physical model.
3. Compute model predictions.
4. Compare observations with predictions.
5. Calculate residuals and percent error.
6. Save a reproducible summary table.

Model:
    T = 2π sqrt(L / g)

Variables:
    T = period in seconds
    L = pendulum length in meters
    g = gravitational acceleration in meters per second squared
"""

from pathlib import Path

import numpy as np
import pandas as pd


GRAVITY_M_PER_S2 = 9.80665


def ideal_pendulum_period(length_m: np.ndarray) -> np.ndarray:
    """
    Compute the ideal small-angle pendulum period.

    Parameters
    ----------
    length_m:
        Pendulum length in meters.

    Returns
    -------
    np.ndarray
        Predicted period in seconds.
    """
    return 2.0 * np.pi * np.sqrt(length_m / GRAVITY_M_PER_S2)


def main() -> None:
    """
    Load measurement data and compare observed periods with model predictions.
    """
    article_dir = Path(__file__).resolve().parents[1]
    data_path = article_dir / "data" / "pendulum_measurements.csv"
    output_path = article_dir / "data" / "pendulum_model_summary.csv"

    measurements = pd.read_csv(data_path)

    measurements["predicted_period_s"] = ideal_pendulum_period(
        measurements["length_m"].to_numpy()
    )

    measurements["residual_s"] = (
        measurements["period_s"] - measurements["predicted_period_s"]
    )

    measurements["percent_error"] = (
        measurements["residual_s"] / measurements["predicted_period_s"]
    ) * 100.0

    grouped_summary = (
        measurements
        .groupby("length_m", as_index=False)
        .agg(
            n_trials=("period_s", "count"),
            mean_observed_period_s=("period_s", "mean"),
            sd_observed_period_s=("period_s", "std"),
            predicted_period_s=("predicted_period_s", "mean"),
            mean_residual_s=("residual_s", "mean"),
            mean_percent_error=("percent_error", "mean"),
        )
    )

    grouped_summary.to_csv(output_path, index=False)

    print("Measurement-level comparison:")
    print(measurements.round(5).to_string(index=False))

    print("\nGrouped model-data summary:")
    print(grouped_summary.round(5).to_string(index=False))

    print(f"\nSaved summary to: {output_path}")


if __name__ == "__main__":
    main()
