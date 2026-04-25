"""
Hohmann Transfer Scaffold

This workflow computes ideal two-burn Hohmann transfer delta-v between
coplanar circular orbits.

Relations:
    a_t = (r1 + r2)/2
    v_circ = sqrt(mu/r)
    v_transfer = sqrt(mu(2/r - 1/a_t))
"""

from pathlib import Path

import numpy as np
import pandas as pd


def hohmann_delta_v(mu: float, r1: float, r2: float) -> dict:
    """
    Compute ideal Hohmann transfer delta-v values.
    """
    transfer_semimajor_axis_m = 0.5 * (r1 + r2)

    v1_circular = np.sqrt(mu / r1)
    v2_circular = np.sqrt(mu / r2)

    v_transfer_periapsis = np.sqrt(
        mu * (2.0 / r1 - 1.0 / transfer_semimajor_axis_m)
    )
    v_transfer_apoapsis = np.sqrt(
        mu * (2.0 / r2 - 1.0 / transfer_semimajor_axis_m)
    )

    delta_v1 = v_transfer_periapsis - v1_circular
    delta_v2 = v2_circular - v_transfer_apoapsis

    transfer_time_s = np.pi * np.sqrt(
        transfer_semimajor_axis_m**3 / mu
    )

    return {
        "transfer_semimajor_axis_m": transfer_semimajor_axis_m,
        "initial_circular_speed_m_per_s": v1_circular,
        "final_circular_speed_m_per_s": v2_circular,
        "transfer_periapsis_speed_m_per_s": v_transfer_periapsis,
        "transfer_apoapsis_speed_m_per_s": v_transfer_apoapsis,
        "delta_v1_m_per_s": delta_v1,
        "delta_v2_m_per_s": delta_v2,
        "total_delta_v_m_per_s": abs(delta_v1) + abs(delta_v2),
        "transfer_time_s": transfer_time_s,
    }


def main() -> None:
    """
    Compute Hohmann transfer scaffolds for sample cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    bodies_path = article_dir / "data" / "central_bodies.csv"
    cases_path = article_dir / "data" / "hohmann_transfer_cases.csv"
    output_path = article_dir / "data" / "computed_hohmann_transfer_scaffold.csv"

    bodies = pd.read_csv(bodies_path)
    cases = pd.read_csv(cases_path)

    table = cases.merge(
        bodies[["body", "mu_m3_per_s2"]],
        left_on="central_body",
        right_on="body",
        how="left",
    )

    rows = []

    for _, row in table.iterrows():
        result = hohmann_delta_v(
            mu=row["mu_m3_per_s2"],
            r1=row["r1_m"],
            r2=row["r2_m"],
        )
        result["case_id"] = row["case_id"]
        result["central_body"] = row["central_body"]
        result["r1_m"] = row["r1_m"]
        result["r2_m"] = row["r2_m"]
        rows.append(result)

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Hohmann transfer scaffold:")
    print(output.round(6).to_string(index=False))
    print(f"\nSaved transfer table to: {output_path}")


if __name__ == "__main__":
    main()
