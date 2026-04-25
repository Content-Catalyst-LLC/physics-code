"""
Overdamped Josephson Junction Dynamics

Dimensionless model:

    dphi/dt = i_bias - sin(phi)
"""

from pathlib import Path

import numpy as np
import pandas as pd


def simulate_case(case: pd.Series) -> pd.DataFrame:
    """
    Simulate one Josephson phase-dynamics case.
    """
    phase = float(case["initial_phase"])
    time_step = float(case["time_step"])
    n_steps = int(case["n_steps"])
    i_bias = float(case["i_bias"])

    rows = []

    for step in range(n_steps):
        time = step * time_step
        phase_velocity = i_bias - np.sin(phase)
        phase += time_step * phase_velocity

        rows.append(
            {
                "case_id": case["case_id"],
                "time": time,
                "i_bias": i_bias,
                "phase": phase,
                "phase_velocity": phase_velocity,
                "josephson_current_normalized": np.sin(phase),
                "notes": case["notes"],
            }
        )

    return pd.DataFrame(rows)


def summarize_case(data: pd.DataFrame) -> dict:
    """
    Summarize late-time Josephson dynamics.
    """
    late = data.iloc[len(data) // 2 :]

    return {
        "case_id": data["case_id"].iloc[0],
        "i_bias": data["i_bias"].iloc[0],
        "mean_phase_velocity_late": late["phase_velocity"].mean(),
        "mean_josephson_current_late": late["josephson_current_normalized"].mean(),
        "phase_range_late": late["phase"].max() - late["phase"].min(),
    }


def main() -> None:
    """
    Run configured Josephson cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "josephson_cases.csv")

    simulations = [simulate_case(case) for _, case in cases.iterrows()]
    output = pd.concat(simulations, ignore_index=True)
    summary = pd.DataFrame([summarize_case(data) for data in simulations])

    output.to_csv(article_dir / "data" / "computed_josephson_dynamics.csv", index=False)
    summary.to_csv(article_dir / "data" / "computed_josephson_summary.csv", index=False)

    print("Josephson dynamics summary:")
    print(summary.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
