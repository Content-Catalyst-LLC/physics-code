"""
Pendulum Uncertainty Propagation

This workflow estimates gravitational acceleration from:

    g = 4*pi^2*L / T^2

and propagates first-order uncertainty from length and period:

    u_c^2(g) =
      (partial g / partial L)^2 u^2(L) +
      (partial g / partial T)^2 u^2(T)
"""

from pathlib import Path

import numpy as np
import pandas as pd


def estimate_gravity(length_m: float, period_s: float) -> float:
    """
    Estimate gravitational acceleration from pendulum length and period.
    """
    return 4.0 * np.pi**2 * length_m / period_s**2


def propagate_gravity_uncertainty(
    length_m: float,
    period_s: float,
    length_uncertainty_m: float,
    period_uncertainty_s: float,
) -> float:
    """
    Propagate first-order uncertainty for g = 4*pi^2*L/T^2.
    """
    partial_g_partial_length = 4.0 * np.pi**2 / period_s**2
    partial_g_partial_period = -8.0 * np.pi**2 * length_m / period_s**3

    combined_variance = (
        partial_g_partial_length**2 * length_uncertainty_m**2
        + partial_g_partial_period**2 * period_uncertainty_s**2
    )

    return float(np.sqrt(combined_variance))


def main() -> None:
    """
    Load repeated measurements, estimate g, and propagate uncertainty.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "pendulum_measurements.csv"
    output_path = article_dir / "data" / "computed_pendulum_uncertainty.csv"

    measurements = pd.read_csv(input_path)
    measurements["period_s"] = measurements["time_10_oscillations_s"] / 10.0

    length_m = float(measurements["length_m"].iloc[0])
    mean_period_s = float(measurements["period_s"].mean())
    period_uncertainty_s = float(measurements["period_s"].std(ddof=1) / np.sqrt(len(measurements)))
    length_uncertainty_m = 0.001

    g_estimate = estimate_gravity(length_m, mean_period_s)
    g_uncertainty = propagate_gravity_uncertainty(
        length_m=length_m,
        period_s=mean_period_s,
        length_uncertainty_m=length_uncertainty_m,
        period_uncertainty_s=period_uncertainty_s,
    )

    summary = pd.DataFrame(
        [
            {
                "n_trials": len(measurements),
                "length_m": length_m,
                "length_uncertainty_m": length_uncertainty_m,
                "mean_period_s": mean_period_s,
                "period_uncertainty_s": period_uncertainty_s,
                "g_estimate_m_per_s2": g_estimate,
                "combined_uncertainty_g_m_per_s2": g_uncertainty,
            }
        ]
    )

    summary.to_csv(output_path, index=False)

    print("Pendulum uncertainty summary:")
    print(summary.round(10).to_string(index=False))
    print(f"\nSaved uncertainty summary to: {output_path}")


if __name__ == "__main__":
    main()
