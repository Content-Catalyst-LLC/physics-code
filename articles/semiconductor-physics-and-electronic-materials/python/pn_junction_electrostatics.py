"""
P-N Junction Electrostatics

This workflow computes built-in potential and depletion width for abrupt
junction cases using the depletion approximation:

    Vbi = (kB T/q) ln(NA ND / ni^2)

    W = sqrt[(2 eps_s/q)((NA+ND)/(NA ND))(Vbi - V)]
"""

from pathlib import Path

import numpy as np
import pandas as pd


ELEMENTARY_CHARGE_C = 1.602176634e-19
BOLTZMANN_CONSTANT_J_K = 1.380649e-23
VACUUM_PERMITTIVITY_F_M = 8.8541878128e-12


def main() -> None:
    """
    Compute p-n junction electrostatic quantities for sample cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "pn_junction_cases.csv"
    output_path = article_dir / "data" / "computed_pn_junction_electrostatics.csv"

    cases = pd.read_csv(input_path)
    rows = []

    for _, row in cases.iterrows():
        na_m3 = row["acceptor_cm3"] * 1.0e6
        nd_m3 = row["donor_cm3"] * 1.0e6
        ni_m3 = row["intrinsic_cm3"] * 1.0e6

        thermal_voltage_v = (
            BOLTZMANN_CONSTANT_J_K * row["temperature_k"] / ELEMENTARY_CHARGE_C
        )

        built_in_potential_v = thermal_voltage_v * np.log(
            (na_m3 * nd_m3) / (ni_m3**2)
        )

        epsilon_s = row["relative_permittivity"] * VACUUM_PERMITTIVITY_F_M
        potential_drop = built_in_potential_v - row["applied_voltage_v"]

        if potential_drop <= 0.0:
            depletion_width_m = np.nan
        else:
            depletion_width_m = np.sqrt(
                (2.0 * epsilon_s / ELEMENTARY_CHARGE_C)
                * ((na_m3 + nd_m3) / (na_m3 * nd_m3))
                * potential_drop
            )

        rows.append(
            {
                "case_id": row["case_id"],
                "acceptor_cm3": row["acceptor_cm3"],
                "donor_cm3": row["donor_cm3"],
                "intrinsic_cm3": row["intrinsic_cm3"],
                "temperature_k": row["temperature_k"],
                "applied_voltage_v": row["applied_voltage_v"],
                "thermal_voltage_v": thermal_voltage_v,
                "built_in_potential_v": built_in_potential_v,
                "depletion_width_m": depletion_width_m,
                "depletion_width_um": depletion_width_m * 1.0e6
                if np.isfinite(depletion_width_m)
                else np.nan,
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("P-N junction electrostatics:")
    print(output.round(8).to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()
