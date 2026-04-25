"""
Overdamped Langevin Dynamics in a Harmonic Potential

Simulates:

    dx = mu F(x) dt + sqrt(2D dt) * Normal(0, 1)

with:

    F(x) = -k x
    D = mu k_B T

The expected equilibrium variance is:

    Var(x) = k_B T / k
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd


def simulate_case(case: pd.Series) -> tuple[pd.DataFrame, dict]:
    """
    Simulate one Langevin trajectory case using Euler-Maruyama integration.
    """
    rng = np.random.default_rng(42)

    n_steps = int(case["n_steps"])
    time_step = float(case["time_step"])
    spring_constant = float(case["spring_constant"])
    mobility = float(case["mobility"])
    thermal_energy = float(case["thermal_energy"])
    position = float(case["initial_position"])

    diffusion = mobility * thermal_energy
    noise_scale = np.sqrt(2.0 * diffusion * time_step)

    rows = []

    for step in range(n_steps):
        time = step * time_step
        force = -spring_constant * position
        position += mobility * force * time_step + noise_scale * rng.normal()
        potential_energy = 0.5 * spring_constant * position**2

        if step % 10 == 0:
            rows.append(
                {
                    "case_id": case["case_id"],
                    "step": step,
                    "time": time,
                    "position": position,
                    "force": force,
                    "potential_energy": potential_energy,
                    "diffusion": diffusion,
                }
            )

    trajectory = pd.DataFrame(rows)
    burn_in = int(len(trajectory) * 0.25)
    late = trajectory.iloc[burn_in:]

    expected_variance = thermal_energy / spring_constant
    simulated_variance = float(late["position"].var())

    summary = {
        "case_id": case["case_id"],
        "diffusion": diffusion,
        "expected_variance": expected_variance,
        "simulated_mean_late": float(late["position"].mean()),
        "simulated_variance_late": simulated_variance,
        "relative_variance_error": abs(simulated_variance - expected_variance) / expected_variance,
        "notes": case["notes"],
    }

    return trajectory, summary


def main() -> None:
    """
    Run all configured Langevin cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "langevin_cases.csv")

    trajectories = []
    summaries = []

    for _, case in cases.iterrows():
        trajectory, summary = simulate_case(case)
        trajectories.append(trajectory)
        summaries.append(summary)

    trajectory_output = pd.concat(trajectories, ignore_index=True)
    summary_output = pd.DataFrame(summaries)

    trajectory_output.to_csv(article_dir / "data" / "computed_langevin_trajectories.csv", index=False)
    summary_output.to_csv(article_dir / "data" / "computed_langevin_summary.csv", index=False)

    print("Langevin summary:")
    print(summary_output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
