"""
Friedmann Expansion Scale Diagnostics

This workflow computes H(z) for simple cosmological parameter cases:

    H(z)^2 = H0^2 [Omega_m (1+z)^3 + Omega_k (1+z)^2 + Omega_Lambda]

Radiation is omitted for this introductory scaffold.
"""

from pathlib import Path

import numpy as np
import pandas as pd


MPC_M = 3.085677581491367e22


def hubble_si(hubble_km_s_mpc: float) -> float:
    """
    Convert Hubble parameter from km/s/Mpc to 1/s.
    """
    return hubble_km_s_mpc * 1000.0 / MPC_M


def main() -> None:
    """
    Compute H(z) tables for sample cosmological cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "cosmology_cases.csv"
    output_path = article_dir / "data" / "computed_friedmann_scales.csv"

    cases = pd.read_csv(input_path)
    redshifts = np.array([0.0, 0.5, 1.0, 2.0, 5.0, 10.0])

    rows = []

    for _, case in cases.iterrows():
        h0_si = hubble_si(case["hubble_km_s_mpc"])

        for z in redshifts:
            ez_squared = (
                case["omega_m"] * (1.0 + z) ** 3
                + case["omega_k"] * (1.0 + z) ** 2
                + case["omega_lambda"]
            )

            hz_si = h0_si * np.sqrt(ez_squared)
            hz_km_s_mpc = hz_si * MPC_M / 1000.0

            rows.append(
                {
                    "case_id": case["case_id"],
                    "redshift": z,
                    "hubble_km_s_mpc": hz_km_s_mpc,
                    "hubble_si": hz_si,
                    "hubble_time_gyr": 1.0 / hz_si / (3600 * 24 * 365.25 * 1e9),
                    "notes": case["notes"],
                }
            )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Friedmann scale diagnostics:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
