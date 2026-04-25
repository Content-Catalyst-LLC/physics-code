"""
Stochastic Molecular Motor Stepping

This toy model simulates a motor that can step forward or backward
during each small time interval.

The expected event probabilities per time step are approximated as:

    p_forward ≈ k_forward dt
    p_backward ≈ k_backward dt

This is a teaching scaffold, not a full chemomechanical motor model.
"""

from pathlib import Path

import numpy as np
import pandas as pd


RANDOM_SEED = 123


def simulate_motor(case_id: str, step_size_nm: float, forward_rate_s: float,
                   backward_rate_s: float, n_steps: int, time_step_s: float) -> pd.DataFrame:
    """
    Simulate stochastic motor stepping for one parameter case.
    """
    rng = np.random.default_rng(abs(hash(case_id)) % (2**32))

    p_forward = forward_rate_s * time_step_s
    p_backward = backward_rate_s * time_step_s

    if p_forward + p_backward > 1.0:
        raise ValueError("Time step too large for event probabilities.")

    position_nm = 0.0
    rows = []

    for step in range(n_steps + 1):
        time_s = step * time_step_s

        rows.append(
            {
                "case_id": case_id,
                "step_index": step,
                "time_s": time_s,
                "position_nm": position_nm,
            }
        )

        if step < n_steps:
            event = rng.random()

            if event < p_forward:
                position_nm += step_size_nm
            elif event < p_forward + p_backward:
                position_nm -= step_size_nm

    return pd.DataFrame(rows)


def main() -> None:
    """
    Simulate stochastic motor stepping cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "motor_step_cases.csv"
    output_path = article_dir / "data" / "computed_molecular_motor_stepping.csv"
    summary_path = article_dir / "data" / "computed_molecular_motor_summary.csv"

    cases = pd.read_csv(input_path)

    frames = [
        simulate_motor(
            row["case_id"],
            row["step_size_nm"],
            row["forward_rate_s"],
            row["backward_rate_s"],
            int(row["n_steps"]),
            row["time_step_s"],
        )
        for _, row in cases.iterrows()
    ]

    output = pd.concat(frames, ignore_index=True)

    summary = (
        output
        .sort_values(["case_id", "step_index"])
        .groupby("case_id", as_index=False)
        .tail(1)[["case_id", "time_s", "position_nm"]]
        .assign(mean_velocity_nm_s=lambda df: df["position_nm"] / df["time_s"])
    )

    output.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Molecular motor summary:")
    print(summary.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
