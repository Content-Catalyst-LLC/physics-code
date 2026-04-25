"""
Ideal and Drag-Including Projectile Motion

This workflow compares two projectile models:

1. Ideal projectile:
       ax = 0
       ay = -g

2. Projectile with quadratic drag:
       a_drag = -c |v| v

The workflow writes reusable CSV outputs for article, notebook, and dashboard work.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp


GRAVITY_M_PER_S2 = 9.80665
INITIAL_SPEED_M_PER_S = 12.0
LAUNCH_ANGLE_RAD = np.pi / 4
DRAG_COEFFICIENT_PER_M = 0.08


def initial_state() -> list[float]:
    """
    Return initial projectile state:
        [x, y, vx, vy]
    """
    initial_vx = INITIAL_SPEED_M_PER_S * np.cos(LAUNCH_ANGLE_RAD)
    initial_vy = INITIAL_SPEED_M_PER_S * np.sin(LAUNCH_ANGLE_RAD)

    return [0.0, 0.0, initial_vx, initial_vy]


def ideal_projectile(time_s: float, state: np.ndarray) -> list[float]:
    """
    Derivatives for ideal projectile motion without air resistance.
    """
    x_m, y_m, vx_m_per_s, vy_m_per_s = state

    return [
        vx_m_per_s,
        vy_m_per_s,
        0.0,
        -GRAVITY_M_PER_S2,
    ]


def drag_projectile(time_s: float, state: np.ndarray) -> list[float]:
    """
    Derivatives for projectile motion with simple quadratic drag.
    """
    x_m, y_m, vx_m_per_s, vy_m_per_s = state
    speed_m_per_s = np.sqrt(vx_m_per_s**2 + vy_m_per_s**2)

    ax_m_per_s2 = -DRAG_COEFFICIENT_PER_M * speed_m_per_s * vx_m_per_s
    ay_m_per_s2 = (
        -GRAVITY_M_PER_S2
        -DRAG_COEFFICIENT_PER_M * speed_m_per_s * vy_m_per_s
    )

    return [
        vx_m_per_s,
        vy_m_per_s,
        ax_m_per_s2,
        ay_m_per_s2,
    ]


def solution_to_table(solution, model_name: str) -> pd.DataFrame:
    """
    Convert a SciPy solution object into a tidy trajectory table.
    """
    table = pd.DataFrame(
        {
            "model": model_name,
            "time_s": solution.t,
            "x_m": solution.y[0],
            "y_m": solution.y[1],
            "vx_m_per_s": solution.y[2],
            "vy_m_per_s": solution.y[3],
        }
    )

    table["speed_m_per_s"] = np.sqrt(
        table["vx_m_per_s"]**2 + table["vy_m_per_s"]**2
    )

    return table[table["y_m"] >= 0.0].copy()


def summarize_trajectory(table: pd.DataFrame) -> pd.DataFrame:
    """
    Summarize flight time, range, maximum height, and maximum speed.
    """
    return (
        table.groupby("model")
        .agg(
            flight_time_s=("time_s", "max"),
            range_m=("x_m", "max"),
            maximum_height_m=("y_m", "max"),
            maximum_speed_m_per_s=("speed_m_per_s", "max"),
        )
        .reset_index()
    )


def main() -> None:
    """
    Simulate ideal and drag-including projectile trajectories.
    """
    article_dir = Path(__file__).resolve().parents[1]
    trajectory_output = article_dir / "data" / "computed_projectile_trajectories.csv"
    summary_output = article_dir / "data" / "computed_projectile_summary.csv"

    time_eval_s = np.linspace(0.0, 2.0, 500)

    ideal_solution = solve_ivp(
        ideal_projectile,
        (0.0, 2.0),
        initial_state(),
        t_eval=time_eval_s,
        rtol=1e-9,
        atol=1e-11,
    )

    drag_solution = solve_ivp(
        drag_projectile,
        (0.0, 2.0),
        initial_state(),
        t_eval=time_eval_s,
        rtol=1e-9,
        atol=1e-11,
    )

    trajectory_table = pd.concat(
        [
            solution_to_table(ideal_solution, "ideal"),
            solution_to_table(drag_solution, "quadratic_drag"),
        ],
        ignore_index=True,
    )

    summary = summarize_trajectory(trajectory_table)

    trajectory_table.to_csv(trajectory_output, index=False)
    summary.to_csv(summary_output, index=False)

    print("Trajectory sample:")
    print(trajectory_table.head(12).round(8).to_string(index=False))

    print("\nTrajectory summary:")
    print(summary.round(8).to_string(index=False))

    print(f"\nSaved trajectory table to: {trajectory_output}")
    print(f"Saved summary to: {summary_output}")


if __name__ == "__main__":
    main()
