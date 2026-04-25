"""
Gyroscope-Style Precession Scaffold

This workflow estimates simple steady precession using:

    Omega = tau / L

with:
    tau = M g r
    L = I omega

This is an idealized scaffold, not a full rigid-body gyroscope model.
"""

from pathlib import Path

import numpy as np
import pandas as pd


G = 9.80665


def main() -> None:
    """
    Estimate precessional angular velocity for illustrative gyroscope cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "gyroscope_cases.csv"
    output_path = article_dir / "data" / "computed_gyroscope_precession.csv"

    cases = pd.read_csv(input_path)

    cases["torque_n_m"] = cases["mass_kg"] * G * cases["lever_arm_m"]
    cases["spin_angular_momentum_kg_m2_per_s"] = (
        cases["moment_of_inertia_kg_m2"] * cases["spin_omega_rad_per_s"]
    )
    cases["precession_omega_rad_per_s"] = (
        cases["torque_n_m"] / cases["spin_angular_momentum_kg_m2_per_s"]
    )
    cases["precession_period_s"] = (
        2.0 * np.pi / cases["precession_omega_rad_per_s"]
    )

    cases.to_csv(output_path, index=False)

    print("Gyroscope-style precession scaffold:")
    print(cases.round(8).to_string(index=False))
    print(f"\nSaved precession table to: {output_path}")


if __name__ == "__main__":
    main()
