"""
Beam Deflection Scaffold

This workflow computes ideal maximum deflection for a simply supported beam
with a central point load:

    delta_max = P L^3 / (48 E I)

where:
    P = point load
    L = beam length
    E = Young's modulus
    I = second moment of area

This is a teaching scaffold and does not replace structural design.
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Compute beam deflection for illustrative cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "beam_cases.csv"
    output_path = article_dir / "data" / "computed_beam_deflection_scaffold.csv"

    cases = pd.read_csv(input_path)

    cases["youngs_modulus_pa"] = cases["youngs_modulus_gpa"] * 1.0e9
    cases["max_deflection_m"] = (
        cases["point_load_n"] * cases["length_m"]**3
        / (48.0 * cases["youngs_modulus_pa"] * cases["second_moment_area_m4"])
    )
    cases["max_deflection_mm"] = cases["max_deflection_m"] * 1000.0

    cases.to_csv(output_path, index=False)

    print("Beam deflection scaffold:")
    print(cases.round(8).to_string(index=False))
    print(f"\nSaved beam table to: {output_path}")


if __name__ == "__main__":
    main()
