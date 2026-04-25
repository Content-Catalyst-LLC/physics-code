"""
Mobility and Conductivity Model

This workflow computes:

    sigma = q n mu

for sample carrier concentrations and mobilities.
"""

from pathlib import Path

import pandas as pd


ELEMENTARY_CHARGE_C = 1.602176634e-19


def main() -> None:
    """
    Compute conductivity and resistivity for sample doping-mobility cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "doping_mobility_cases.csv"
    output_path = article_dir / "data" / "computed_mobility_conductivity.csv"

    cases = pd.read_csv(input_path)

    cases["carrier_concentration_m3"] = cases["carrier_concentration_cm3"] * 1.0e6
    cases["mobility_m2_v_s"] = cases["mobility_cm2_v_s"] * 1.0e-4

    cases["conductivity_s_m"] = (
        ELEMENTARY_CHARGE_C
        * cases["carrier_concentration_m3"]
        * cases["mobility_m2_v_s"]
    )

    cases["resistivity_ohm_m"] = 1.0 / cases["conductivity_s_m"]
    cases["resistivity_ohm_cm"] = cases["resistivity_ohm_m"] * 100.0

    cases.to_csv(output_path, index=False)

    print("Mobility and conductivity table:")
    print(cases.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
