"""
MOS Oxide Capacitance

This workflow computes oxide capacitance per unit area:

    Cox = epsilon_ox / tox

and converts between F/m^2 and uF/cm^2.
"""

from pathlib import Path

import pandas as pd


VACUUM_PERMITTIVITY_F_M = 8.8541878128e-12


def main() -> None:
    """
    Compute oxide capacitance per unit area for sample MOS oxide cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "mos_oxide_cases.csv"
    output_path = article_dir / "data" / "computed_mos_oxide_capacitance.csv"

    cases = pd.read_csv(input_path)

    cases["oxide_thickness_m"] = cases["oxide_thickness_nm"] * 1.0e-9
    cases["oxide_permittivity_f_m"] = (
        cases["relative_permittivity"] * VACUUM_PERMITTIVITY_F_M
    )
    cases["cox_f_m2"] = cases["oxide_permittivity_f_m"] / cases["oxide_thickness_m"]
    cases["cox_uf_cm2"] = cases["cox_f_m2"] * 100.0

    cases.to_csv(output_path, index=False)

    print("MOS oxide capacitance:")
    print(cases.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
