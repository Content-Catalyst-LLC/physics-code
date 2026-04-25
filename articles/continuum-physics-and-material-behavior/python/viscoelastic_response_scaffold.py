"""
Viscoelastic Stress Relaxation Scaffold

This workflow models a simple exponential stress relaxation response:

    E(t) = E_relaxed + (E_initial - E_relaxed) exp(-t/tau)
    sigma(t) = E(t) * epsilon0

This is a teaching scaffold for time-dependent material behavior.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Compute stress relaxation curves for sample material cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "viscoelastic_cases.csv"
    output_path = article_dir / "data" / "computed_viscoelastic_relaxation.csv"

    cases = pd.read_csv(input_path)
    time_s = np.linspace(0.0, 180.0, 361)

    rows = []

    for _, row in cases.iterrows():
        e_initial_pa = row["instantaneous_modulus_mpa"] * 1.0e6
        e_relaxed_pa = row["relaxed_modulus_mpa"] * 1.0e6
        tau_s = row["relaxation_time_s"]
        strain = row["applied_strain"]

        relaxation_modulus_pa = (
            e_relaxed_pa + (e_initial_pa - e_relaxed_pa) * np.exp(-time_s / tau_s)
        )

        stress_pa = relaxation_modulus_pa * strain

        for t, modulus, stress in zip(time_s, relaxation_modulus_pa, stress_pa):
            rows.append(
                {
                    "case_id": row["case_id"],
                    "time_s": t,
                    "relaxation_modulus_mpa": modulus / 1.0e6,
                    "stress_mpa": stress / 1.0e6,
                    "applied_strain": strain,
                }
            )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Viscoelastic relaxation sample:")
    print(output.head(15).round(6).to_string(index=False))
    print(f"\nSaved relaxation table to: {output_path}")


if __name__ == "__main__":
    main()
