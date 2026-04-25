"""
Orbital Energy Diagnostics

This workflow computes circular speed, escape speed, specific orbital energy,
and orbital classification for a set of orbital cases.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def classify_specific_energy(epsilon: float, tolerance: float = 1e-3) -> str:
    """
    Classify an ideal orbit based on specific orbital energy.
    """
    if epsilon < -tolerance:
        return "bound_elliptic"
    if epsilon > tolerance:
        return "unbound_hyperbolic"
    return "parabolic_threshold"


def main() -> None:
    """
    Compute energy diagnostics for circular and scaled orbital speeds.
    """
    article_dir = Path(__file__).resolve().parents[1]
    bodies_path = article_dir / "data" / "central_bodies.csv"
    cases_path = article_dir / "data" / "orbital_cases.csv"
    output_path = article_dir / "data" / "computed_orbital_energy_diagnostics.csv"

    bodies = pd.read_csv(bodies_path)
    cases = pd.read_csv(cases_path)

    table = cases.merge(
        bodies[["body", "mu_m3_per_s2", "radius_m"]],
        left_on="central_body",
        right_on="body",
        how="left",
        suffixes=("", "_central"),
    )

    table["orbital_radius_m"] = table["radius_m"] + table["altitude_m"]
    table["circular_speed_m_per_s"] = np.sqrt(
        table["mu_m3_per_s2"] / table["orbital_radius_m"]
    )
    table["escape_speed_m_per_s"] = np.sqrt(
        2.0 * table["mu_m3_per_s2"] / table["orbital_radius_m"]
    )
    table["circular_specific_energy_j_per_kg"] = (
        0.5 * table["circular_speed_m_per_s"]**2
        - table["mu_m3_per_s2"] / table["orbital_radius_m"]
    )
    table["escape_specific_energy_j_per_kg"] = (
        0.5 * table["escape_speed_m_per_s"]**2
        - table["mu_m3_per_s2"] / table["orbital_radius_m"]
    )
    table["circular_orbit_classification"] = table[
        "circular_specific_energy_j_per_kg"
    ].apply(classify_specific_energy)

    table.to_csv(output_path, index=False)

    print("Orbital energy diagnostics:")
    print(table.round(6).to_string(index=False))
    print(f"\nSaved diagnostics to: {output_path}")


if __name__ == "__main__":
    main()
