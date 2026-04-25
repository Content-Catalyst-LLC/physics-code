"""
Brownian Motion and Mean Squared Displacement

This workflow simulates two-dimensional Brownian motion using:

    dx ~ Normal(0, sqrt(2 D dt))
    dy ~ Normal(0, sqrt(2 D dt))

For two-dimensional diffusion, the expected mean squared displacement is:

    MSD(t) = 4 D t
"""

from pathlib import Path

import numpy as np
import pandas as pd


DIFFUSION_COEFFICIENT_UM2_S = 1.0
TIME_STEP_S = 0.01
N_STEPS = 1000
N_TRAJECTORIES = 500
RANDOM_SEED = 42


def simulate_brownian_motion() -> pd.DataFrame:
    """
    Simulate Brownian motion trajectories in two spatial dimensions.
    """
    rng = np.random.default_rng(RANDOM_SEED)

    step_standard_deviation = np.sqrt(
        2.0 * DIFFUSION_COEFFICIENT_UM2_S * TIME_STEP_S
    )

    rows = []

    for trajectory_id in range(N_TRAJECTORIES):
        x_um = 0.0
        y_um = 0.0

        for step in range(N_STEPS + 1):
            time_s = step * TIME_STEP_S

            rows.append(
                {
                    "trajectory_id": trajectory_id,
                    "step": step,
                    "time_s": time_s,
                    "x_um": x_um,
                    "y_um": y_um,
                    "squared_displacement_um2": x_um**2 + y_um**2,
                }
            )

            if step < N_STEPS:
                dx_um = rng.normal(0.0, step_standard_deviation)
                dy_um = rng.normal(0.0, step_standard_deviation)

                x_um += dx_um
                y_um += dy_um

    return pd.DataFrame(rows)


def main() -> None:
    """
    Run the Brownian simulation and summarize mean squared displacement.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_brownian_motion_trajectories.csv"
    summary_path = article_dir / "data" / "computed_brownian_motion_msd.csv"

    trajectories = simulate_brownian_motion()

    msd_summary = (
        trajectories
        .groupby("time_s", as_index=False)
        .agg(
            mean_squared_displacement_um2=(
                "squared_displacement_um2",
                "mean",
            ),
            sd_squared_displacement_um2=(
                "squared_displacement_um2",
                "std",
            ),
        )
    )

    msd_summary["theoretical_msd_um2"] = (
        4.0 * DIFFUSION_COEFFICIENT_UM2_S * msd_summary["time_s"]
    )

    trajectories.to_csv(output_path, index=False)
    msd_summary.to_csv(summary_path, index=False)

    selected = msd_summary.iloc[::100, :]

    print("Mean squared displacement summary:")
    print(selected.round(6).to_string(index=False))

    final_row = msd_summary.iloc[-1]

    print("\nFinal-time comparison:")
    print(
        pd.DataFrame(
            [
                {
                    "diffusion_coefficient_um2_s": DIFFUSION_COEFFICIENT_UM2_S,
                    "final_time_s": final_row["time_s"],
                    "simulated_msd_um2": final_row[
                        "mean_squared_displacement_um2"
                    ],
                    "theoretical_msd_um2": final_row["theoretical_msd_um2"],
                    "relative_error": (
                        final_row["mean_squared_displacement_um2"]
                        - final_row["theoretical_msd_um2"]
                    )
                    / final_row["theoretical_msd_um2"],
                }
            ]
        ).round(6).to_string(index=False)
    )


if __name__ == "__main__":
    main()
