"""
Lorenz System and Lyapunov-Style Trajectory Separation

This workflow integrates two nearby initial conditions for the Lorenz system:

    dx/dt = sigma (y - x)
    dy/dt = x (rho - z) - y
    dz/dt = x y - beta z

It then measures how the distance between the trajectories changes over time.

This is not a full rigorous Lyapunov exponent estimator. It is a readable
diagnostic scaffold for sensitive dependence on initial conditions.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


SIGMA = 10.0
RHO = 28.0
BETA = 8.0 / 3.0

TIME_START = 0.0
TIME_END = 40.0
N_TIME_POINTS = 8000


def lorenz_system(time_s: float, state: np.ndarray) -> list[float]:
    """
    Return derivatives for the Lorenz system.
    """
    x, y, z = state

    dx_dt = SIGMA * (y - x)
    dy_dt = x * (RHO - z) - y
    dz_dt = x * y - BETA * z

    return [dx_dt, dy_dt, dz_dt]


def integrate_lorenz(initial_state: np.ndarray, time_eval: np.ndarray) -> np.ndarray:
    """
    Integrate the Lorenz system for one initial condition.
    """
    solution = solve_ivp(
        lorenz_system,
        (TIME_START, TIME_END),
        initial_state,
        t_eval=time_eval,
        rtol=1e-9,
        atol=1e-11,
    )

    if not solution.success:
        raise RuntimeError(solution.message)

    return solution.y.T


def main() -> None:
    """
    Integrate two nearby Lorenz trajectories and save separation diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    trajectory_path = article_dir / "data" / "computed_lorenz_trajectory_separation.csv"
    summary_path = article_dir / "data" / "computed_lorenz_separation_summary.csv"

    time_eval = np.linspace(TIME_START, TIME_END, N_TIME_POINTS)

    initial_state_a = np.array([1.0, 1.0, 1.0])
    initial_state_b = np.array([1.0 + 1.0e-8, 1.0, 1.0])

    trajectory_a = integrate_lorenz(initial_state_a, time_eval)
    trajectory_b = integrate_lorenz(initial_state_b, time_eval)

    separation = np.linalg.norm(trajectory_b - trajectory_a, axis=1)
    initial_separation = separation[0]

    trajectory_table = pd.DataFrame(
        {
            "time_s": time_eval,
            "x_a": trajectory_a[:, 0],
            "y_a": trajectory_a[:, 1],
            "z_a": trajectory_a[:, 2],
            "x_b": trajectory_b[:, 0],
            "y_b": trajectory_b[:, 1],
            "z_b": trajectory_b[:, 2],
            "trajectory_separation": separation,
            "log_separation_ratio": np.log(
                np.maximum(separation, 1.0e-300) / initial_separation
            ),
        }
    )

    early_window = trajectory_table[
        (trajectory_table["time_s"] >= 0.0) &
        (trajectory_table["time_s"] <= 8.0)
    ]

    slope, intercept = np.polyfit(
        early_window["time_s"],
        early_window["log_separation_ratio"],
        deg=1,
    )

    summary = pd.DataFrame(
        [
            {
                "sigma": SIGMA,
                "rho": RHO,
                "beta": BETA,
                "initial_separation": initial_separation,
                "final_separation": separation[-1],
                "max_separation": separation.max(),
                "early_time_log_separation_slope": slope,
                "early_time_log_separation_intercept": intercept,
            }
        ]
    )

    trajectory_table.to_csv(trajectory_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Lorenz trajectory sample:")
    print(trajectory_table.head(12).round(8).to_string(index=False))

    print("\nSeparation diagnostic summary:")
    print(summary.round(10).to_string(index=False))

    print(f"\nSaved trajectory table to: {trajectory_path}")
    print(f"Saved summary to: {summary_path}")


if __name__ == "__main__":
    main()
