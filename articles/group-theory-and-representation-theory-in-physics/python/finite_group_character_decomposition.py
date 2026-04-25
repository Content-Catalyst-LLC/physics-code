"""
Finite Group Character Decomposition for C3

This workflow uses the C3 character table to decompose reducible characters.
"""

from pathlib import Path

import numpy as np
import pandas as pd


OMEGA = np.exp(2j * np.pi / 3)
CHARACTER_VALUES = {
    "1": 1.0 + 0.0j,
    "omega": OMEGA,
    "omega2": OMEGA**2,
}
GROUP_ELEMENTS = ["e", "r", "r2"]


def parse_character_value(value: str) -> complex:
    """
    Convert stored character tokens into complex values.
    """
    stripped = str(value).strip()
    if stripped in CHARACTER_VALUES:
        return CHARACTER_VALUES[stripped]
    return complex(float(stripped))


def load_character_table(path: Path) -> pd.DataFrame:
    """
    Load C3 character table and parse complex entries.
    """
    table = pd.read_csv(path)

    for element in GROUP_ELEMENTS:
        table[element] = table[element].apply(parse_character_value)

    return table


def decompose_character(character_table: pd.DataFrame, reducible_row: pd.Series) -> pd.DataFrame:
    """
    Decompose a reducible representation using character inner products.
    """
    reducible_character = np.array(
        [
            reducible_row["chi_e"],
            reducible_row["chi_r"],
            reducible_row["chi_r2"],
        ],
        dtype=complex,
    )

    rows = []
    group_order = len(GROUP_ELEMENTS)

    for _, irrep in character_table.iterrows():
        irrep_character = np.array([irrep[element] for element in GROUP_ELEMENTS])
        multiplicity = np.sum(np.conjugate(irrep_character) * reducible_character) / group_order

        rows.append(
            {
                "case_id": reducible_row["case_id"],
                "group_id": reducible_row["group_id"],
                "irrep": irrep["irrep"],
                "multiplicity_real": float(np.real_if_close(multiplicity).real),
                "multiplicity_imaginary": float(np.imag(multiplicity)),
                "notes": reducible_row["notes"],
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Decompose configured reducible characters for C3.
    """
    article_dir = Path(__file__).resolve().parents[1]
    character_path = article_dir / "data" / "c3_character_table.csv"
    reducible_path = article_dir / "data" / "reducible_character_cases.csv"
    output_path = article_dir / "data" / "computed_c3_character_decomposition.csv"

    character_table = load_character_table(character_path)
    reducible_cases = pd.read_csv(reducible_path)

    output = pd.concat(
        [
            decompose_character(character_table, row)
            for _, row in reducible_cases.iterrows()
        ],
        ignore_index=True,
    )

    output.to_csv(output_path, index=False)

    print("C3 character decomposition:")
    print(output.round(10).to_string(index=False))


if __name__ == "__main__":
    main()
