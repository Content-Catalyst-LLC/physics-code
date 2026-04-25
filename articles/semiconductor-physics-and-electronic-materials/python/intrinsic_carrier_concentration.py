"""
Intrinsic Carrier Concentration

This workflow computes:

    ni = sqrt(Nc Nv) exp[-Eg/(2 kB T)]

using Eg in eV and kB T in eV.
"""

from pathlib import Path

import numpy as np
import pandas as pd


BOLTZMANN_EV_K = 8.617333262145e-5


def intrinsic_carrier_cm3(
    band_gap_ev: float,
    nc_cm3: float,
    nv_cm3: float,
    temperature_k: float,
) -> float:
    """
    Compute intrinsic carrier concentration in cm^-3.
    """
    return float(
        np.sqrt(nc_cm3 * nv_cm3)
        * np.exp(-band_gap_ev / (2.0 * BOLTZMANN_EV_K * temperature_k))
    )


def main() -> None:
    """
    Compute intrinsic carrier concentrations for sample materials and temperatures.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "material_parameter_cases.csv"
    output_path = article_dir / "data" / "computed_intrinsic_carrier_concentration.csv"

    materials = pd.read_csv(input_path)
    temperatures = np.array([250.0, 300.0, 350.0, 400.0, 500.0])

    rows = []

    for _, row in materials.iterrows():
        for temperature_k in temperatures:
            ni = intrinsic_carrier_cm3(
                row["band_gap_ev"],
                row["nc_cm3"],
                row["nv_cm3"],
                temperature_k,
            )

            rows.append(
                {
                    "material": row["material"],
                    "temperature_k": temperature_k,
                    "band_gap_ev": row["band_gap_ev"],
                    "nc_cm3": row["nc_cm3"],
                    "nv_cm3": row["nv_cm3"],
                    "intrinsic_carrier_cm3": ni,
                }
            )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Intrinsic carrier concentration table:")
    print(output.round(6).to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()
