"""
Rolling Body Comparison

This workflow compares rolling objects using:

    I = beta M R^2
    a = g sin(theta) / (1 + beta)
    v = sqrt(2 g h / (1 + beta))
    rotational energy fraction = beta / (1 + beta)
"""

from pathlib import Path

import numpy as np
import pandas as pd


G = 9.80665


def main() -> None:
    """
    Compute rolling acceleration, final speed, and energy partition.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "rolling_body_cases.csv"
    output_path = article_dir / "data" / "computed_rolling_body_comparison.csv"

    cases = pd.read_csv(input_path)

    angle_rad = np.deg2rad(cases["incline_angle_deg"])

    cases["acceleration_m_per_s2"] = (
        G * np.sin(angle_rad) / (1.0 + cases["beta"])
    )
    cases["final_speed_m_per_s"] = np.sqrt(
        2.0 * G * cases["height_drop_m"] / (1.0 + cases["beta"])
    )
    cases["translational_energy_fraction"] = 1.0 / (1.0 + cases["beta"])
    cases["rotational_energy_fraction"] = cases["beta"] / (1.0 + cases["beta"])
    cases["moment_of_inertia_kg_m2"] = (
        cases["beta"] * cases["mass_kg"] * cases["radius_m"] ** 2
    )

    cases.to_csv(output_path, index=False)

    print("Rolling body comparison:")
    print(cases.round(8).to_string(index=False))
    print(f"\nSaved comparison to: {output_path}")


if __name__ == "__main__":
    main()
