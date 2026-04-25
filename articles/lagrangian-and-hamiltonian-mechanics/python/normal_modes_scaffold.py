"""
Normal Modes Scaffold

This workflow solves a small generalized eigenvalue problem:

    (K - omega^2 M) a = 0

For two coupled oscillators.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from scipy.linalg import eigh


def main() -> None:
    """
    Compute normal-mode frequencies for sample two-oscillator cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "normal_mode_cases.csv"
    output_path = article_dir / "data" / "computed_normal_modes.csv"

    cases = pd.read_csv(input_path)
    rows = []

    for _, row in cases.iterrows():
        M = np.array(
            [
                [row["mass1_kg"], 0.0],
                [0.0, row["mass2_kg"]],
            ]
        )

        K = np.array(
            [
                [row["k1_n_per_m"] + row["k_coupling_n_per_m"], -row["k_coupling_n_per_m"]],
                [-row["k_coupling_n_per_m"], row["k2_n_per_m"] + row["k_coupling_n_per_m"]],
            ]
        )

        eigenvalues, eigenvectors = eigh(K, M)
        omega = np.sqrt(eigenvalues)

        for mode_index, omega_value in enumerate(omega, start=1):
            rows.append(
                {
                    "case_id": row["case_id"],
                    "mode": mode_index,
                    "omega_rad_per_s": omega_value,
                    "frequency_hz": omega_value / (2.0 * np.pi),
                    "mode_shape_component_1": eigenvectors[0, mode_index - 1],
                    "mode_shape_component_2": eigenvectors[1, mode_index - 1],
                }
            )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Normal modes:")
    print(output.round(8).to_string(index=False))
    print(f"\nSaved normal-mode table to: {output_path}")


if __name__ == "__main__":
    main()
