"""
Pendulum Uncertainty Workflow

This workflow estimates gravitational acceleration using:

    g = 4*pi^2*L / T^2

It computes:

1. A mean period from repeated timing measurements.
2. First-order propagated uncertainty.
3. Monte Carlo propagated uncertainty.

The data are illustrative and are intended for reproducible teaching
and article support.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def estimate_g(length_m: float, period_s: float) -> float:
    """
    Estimate gravitational acceleration from pendulum length and period.

    Parameters
    ----------
    length_m:
        Pendulum length in meters.
    period_s:
        Oscillation period in seconds.

    Returns
    -------
    float
        Estimated gravitational acceleration in m/s^2.
    """
    return 4.0 * np.pi**2 * length_m / period_s**2


def first_order_uncertainty(
    length_m: float,
    u_length_m: float,
    period_s: float,
    u_period_s: float
) -> float:
    """
    Compute first-order propagated uncertainty for g.

    Parameters
    ----------
    length_m:
        Pendulum length in meters.
    u_length_m:
        Standard uncertainty of length in meters.
    period_s:
        Oscillation period in seconds.
    u_period_s:
        Standard uncertainty of period in seconds.

    Returns
    -------
    float
        Combined standard uncertainty of g in m/s^2.
    """
    dg_dlength = 4.0 * np.pi**2 / period_s**2
    dg_dperiod = -8.0 * np.pi**2 * length_m / period_s**3

    return np.sqrt(
        (dg_dlength * u_length_m) ** 2
        + (dg_dperiod * u_period_s) ** 2
    )


def monte_carlo_uncertainty(
    length_m: float,
    u_length_m: float,
    period_s: float,
    u_period_s: float,
    n_samples: int = 100_000,
    seed: int = 42
) -> tuple[float, float]:
    """
    Estimate uncertainty in g using Monte Carlo propagation.

    Parameters
    ----------
    length_m:
        Pendulum length in meters.
    u_length_m:
        Standard uncertainty of length in meters.
    period_s:
        Oscillation period in seconds.
    u_period_s:
        Standard uncertainty of period in seconds.
    n_samples:
        Number of Monte Carlo samples.
    seed:
        Random seed for reproducibility.

    Returns
    -------
    tuple[float, float]
        Mean and standard deviation of simulated g values.
    """
    rng = np.random.default_rng(seed)

    length_samples = rng.normal(length_m, u_length_m, n_samples)
    period_samples = rng.normal(period_s, u_period_s, n_samples)

    g_samples = estimate_g(length_samples, period_samples)

    return float(np.mean(g_samples)), float(np.std(g_samples, ddof=1))


def main() -> None:
    """
    Load pendulum measurements and compute uncertainty summaries.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "pendulum_measurements.csv"
    output_path = article_dir / "data" / "computed_pendulum_uncertainty.csv"

    measurements = pd.read_csv(input_path)
    measurements["period_s"] = measurements["time_for_10_oscillations_s"] / 10.0
    measurements["u_period_s"] = measurements["u_time_for_10_oscillations_s"] / 10.0

    length_m = float(measurements["length_m"].iloc[0])
    u_length_m = float(measurements["u_length_m"].iloc[0])
    mean_period_s = float(measurements["period_s"].mean())
    u_period_s = float(measurements["period_s"].std(ddof=1) / np.sqrt(len(measurements)))

    g_estimate = estimate_g(length_m, mean_period_s)
    u_g_first_order = first_order_uncertainty(length_m, u_length_m, mean_period_s, u_period_s)
    g_mc_mean, u_g_mc = monte_carlo_uncertainty(length_m, u_length_m, mean_period_s, u_period_s)

    summary = pd.DataFrame(
        [
            {
                "length_m": length_m,
                "u_length_m": u_length_m,
                "mean_period_s": mean_period_s,
                "u_period_s": u_period_s,
                "g_estimate_m_s2": g_estimate,
                "u_g_first_order_m_s2": u_g_first_order,
                "g_monte_carlo_mean_m_s2": g_mc_mean,
                "u_g_monte_carlo_m_s2": u_g_mc,
            }
        ]
    )

    summary.to_csv(output_path, index=False)

    print(measurements.round(6).to_string(index=False))
    print("\nPendulum uncertainty summary:")
    print(summary.round(8).to_string(index=False))
    print(f"\nSaved summary to: {output_path}")


if __name__ == "__main__":
    main()
