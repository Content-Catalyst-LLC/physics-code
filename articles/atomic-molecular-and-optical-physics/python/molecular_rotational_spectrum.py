"""
Molecular Rotational Spectrum Scaffold

This workflow computes rotational energies for a rigid rotor:

    E_J = B J(J + 1)

where B is expressed in cm^-1.

For a simple pure rotational transition in a linear rigid rotor:

    Delta J = +1
    transition wavenumber ≈ 2B(J + 1)
"""

from pathlib import Path

import pandas as pd


def build_rotor_table(case_id: str, b_cm_inv: float, j_max: int) -> pd.DataFrame:
    """
    Build rotational energy and transition table for one rotor case.
    """
    rows = []

    for j in range(j_max + 1):
        energy = b_cm_inv * j * (j + 1)

        rows.append(
            {
                "case_id": case_id,
                "J": j,
                "energy_cm_inv": energy,
                "degeneracy": 2 * j + 1,
                "transition_to_J_plus_1_cm_inv":
                    2.0 * b_cm_inv * (j + 1) if j < j_max else None,
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Generate molecular rotational energy tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "molecular_rotor_cases.csv"
    output_path = article_dir / "data" / "computed_molecular_rotational_spectrum.csv"

    cases = pd.read_csv(input_path)

    tables = [
        build_rotor_table(
            case_id=row["case_id"],
            b_cm_inv=row["rotational_constant_cm_inv"],
            j_max=int(row["j_max"]),
        )
        for _, row in cases.iterrows()
    ]

    output = pd.concat(tables, ignore_index=True)
    output.to_csv(output_path, index=False)

    print("Molecular rotational spectrum sample:")
    print(output.head(20).round(8).to_string(index=False))
    print(f"\nSaved rotational table to: {output_path}")


if __name__ == "__main__":
    main()
