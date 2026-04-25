"""
Alfven Speed and Plasma Beta Diagnostics

This workflow computes:
    v_A = B / sqrt(mu_0 rho)
    beta = 2 mu_0 p / B^2
"""

from pathlib import Path

import numpy as np
import pandas as pd


MU_0 = 1.25663706212e-6
E_CHARGE = 1.602176634e-19
AMU_KG = 1.66053906660e-27


def main() -> None:
    """
    Compute Alfven speed and plasma beta for sample regimes.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "plasma_regime_cases.csv"
    output_path = article_dir / "data" / "computed_alfven_beta_diagnostics.csv"

    cases = pd.read_csv(input_path)
    rows = []

    for _, row in cases.iterrows():
        ne = row["electron_density_m3"]
        z = row["charge_state"]
        ni = ne / z
        ion_mass = row["ion_mass_amu"] * AMU_KG
        rho = ni * ion_mass
        b = row["magnetic_field_t"]

        electron_pressure = ne * row["electron_temperature_ev"] * E_CHARGE
        ion_pressure = ni * row["ion_temperature_ev"] * E_CHARGE
        total_pressure = electron_pressure + ion_pressure

        magnetic_pressure = b**2 / (2.0 * MU_0) if b > 0 else np.nan
        beta = total_pressure / magnetic_pressure if magnetic_pressure > 0 else np.nan
        alfven_speed = b / np.sqrt(MU_0 * rho) if rho > 0 else np.nan

        rows.append(
            {
                "case_id": row["case_id"],
                "mass_density_kg_m3": rho,
                "electron_pressure_pa": electron_pressure,
                "ion_pressure_pa": ion_pressure,
                "total_pressure_pa": total_pressure,
                "magnetic_pressure_pa": magnetic_pressure,
                "plasma_beta": beta,
                "alfven_speed_m_s": alfven_speed,
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Alfven speed and beta diagnostics:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
