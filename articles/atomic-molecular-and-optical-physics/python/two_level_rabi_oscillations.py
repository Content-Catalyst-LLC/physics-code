"""
Two-Level Rabi Oscillations

For an ideal driven two-level system:

    Omega_R = sqrt(Omega^2 + Delta^2)

    P_e(t) = [Omega^2 / Omega_R^2] sin^2(Omega_R t / 2)

where:
    Omega = resonant Rabi frequency
    Delta = detuning
"""

from pathlib import Path

import numpy as np
import pandas as pd


def excited_probability(time_s: np.ndarray, omega: float, detuning: float) -> np.ndarray:
    """
    Compute ideal excited-state probability for a driven two-level system.
    """
    omega_r = np.sqrt(omega**2 + detuning**2)
    amplitude = omega**2 / omega_r**2
    return amplitude * np.sin(0.5 * omega_r * time_s) ** 2


def main() -> None:
    """
    Generate Rabi oscillation trajectories for sample cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "rabi_parameter_cases.csv"
    output_path = article_dir / "data" / "computed_rabi_oscillations.csv"
    summary_path = article_dir / "data" / "computed_rabi_oscillation_summary.csv"

    cases = pd.read_csv(input_path)

    frames = []

    for _, row in cases.iterrows():
        time_s = np.linspace(0.0, row["time_end_s"], int(row["n_time_points"]))
        probability = excited_probability(
            time_s,
            row["rabi_frequency_rad_s"],
            row["detuning_rad_s"],
        )

        frames.append(
            pd.DataFrame(
                {
                    "case_id": row["case_id"],
                    "time_s": time_s,
                    "rabi_frequency_rad_s": row["rabi_frequency_rad_s"],
                    "detuning_rad_s": row["detuning_rad_s"],
                    "generalized_rabi_frequency_rad_s":
                        np.sqrt(row["rabi_frequency_rad_s"]**2 + row["detuning_rad_s"]**2),
                    "excited_state_probability": probability,
                }
            )
        )

    output = pd.concat(frames, ignore_index=True)

    summary = (
        output
        .groupby("case_id", as_index=False)
        .agg(
            max_excited_state_probability=("excited_state_probability", "max"),
            mean_excited_state_probability=("excited_state_probability", "mean"),
            generalized_rabi_frequency_rad_s=("generalized_rabi_frequency_rad_s", "first"),
        )
    )

    output.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Rabi oscillation sample:")
    print(output.head(12).round(8).to_string(index=False))

    print("\nSummary:")
    print(summary.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
