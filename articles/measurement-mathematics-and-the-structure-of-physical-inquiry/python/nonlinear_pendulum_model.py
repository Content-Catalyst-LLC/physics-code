"""
Ideal and Nonlinear Pendulum Modeling

This workflow compares:

1. The small-angle pendulum period:
       T = 2*pi*sqrt(L/g)

2. The nonlinear pendulum equation:
       theta'' = -(g/L) sin(theta)

The workflow writes reusable CSV outputs for article, notebook, and dashboard work.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


GRAVITY_M_PER_S2 = 9.80665
LENGTH_M = 0.75


def small_angle_period(length_m: float, gravity_m_per_s2: float) -> float:
    """
    Compute the ideal small-angle pendulum period.
    """
    return 2.0 * np.pi * np.sqrt(length_m / gravity_m_per_s2)


def nonlinear_pendulum(time_s: float, state: np.ndarray) -> list[float]:
    """
    Nonlinear pendulum equation.

    State vector:
        state[0] = angle theta in radians
        state[1] = angular velocity omega in radians per second
    """
    theta_rad, omega_rad_per_s = state
    angular_acceleration_rad_per_s2 = (
        -GRAVITY_M_PER_S2 / LENGTH_M * np.sin(theta_rad)
    )

    return [omega_rad_per_s, angular_acceleration_rad_per_s2]


def estimate_period_from_zero_crossings(
    time_s: np.ndarray,
    theta_rad: np.ndarray,
) -> float:
    """
    Estimate pendulum period from positive-going zero crossings.
    """
    crossings = []

    for i in range(1, len(theta_rad)):
        if theta_rad[i - 1] < 0.0 and theta_rad[i] >= 0.0:
            t0 = time_s[i - 1]
            t1 = time_s[i]
            y0 = theta_rad[i - 1]
            y1 = theta_rad[i]

            crossing_time = t0 - y0 * (t1 - t0) / (y1 - y0)
            crossings.append(crossing_time)

    if len(crossings) < 2:
        return float("nan")

    return float(np.mean(np.diff(crossings)))


def main() -> None:
    """
    Compare small-angle and nonlinear pendulum periods.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_nonlinear_pendulum_model.csv"

    amplitudes_rad = np.array([0.05, 0.20, 0.40, 0.80])
    rows = []

    for amplitude_rad in amplitudes_rad:
        solution = solve_ivp(
            nonlinear_pendulum,
            (0.0, 20.0),
            [amplitude_rad, 0.0],
            t_eval=np.linspace(0.0, 20.0, 5000),
            rtol=1e-10,
            atol=1e-12,
        )

        nonlinear_period_s = estimate_period_from_zero_crossings(
            solution.t,
            solution.y[0],
        )

        ideal_period_s = small_angle_period(
            length_m=LENGTH_M,
            gravity_m_per_s2=GRAVITY_M_PER_S2,
        )

        rows.append(
            {
                "amplitude_rad": amplitude_rad,
                "small_angle_period_s": ideal_period_s,
                "nonlinear_period_s": nonlinear_period_s,
                "relative_difference": (
                    nonlinear_period_s - ideal_period_s
                ) / ideal_period_s,
            }
        )

    summary = pd.DataFrame(rows)
    summary.to_csv(output_path, index=False)

    print("Pendulum model comparison:")
    print(summary.round(8).to_string(index=False))
    print(f"\nSaved model comparison to: {output_path}")


if __name__ == "__main__":
    main()
