"""
Three-Qubit Bit-Flip Code Scaffold

This workflow illustrates syndrome logic for a toy three-qubit bit-flip code.

Encoded states:
    |0_L> = |000>
    |1_L> = |111>

This toy model protects against one bit flip, not arbitrary quantum errors.
"""

from pathlib import Path

import pandas as pd


def syndrome_for_bits(bits: str) -> str:
    """
    Compute parity syndrome for three classical bit values.

    Syndrome bits:
        s1 = b1 XOR b2
        s2 = b2 XOR b3
    """
    b1, b2, b3 = [int(char) for char in bits]
    s1 = b1 ^ b2
    s2 = b2 ^ b3
    return f"{s1}{s2}"


def correction_from_syndrome(syndrome: str) -> str:
    """
    Return correction suggested by the syndrome.
    """
    return {
        "00": "none_or_logical_ambiguity",
        "11": "flip_qubit_1",
        "10": "flip_qubit_2",
        "01": "flip_qubit_3",
    }[syndrome]


def main() -> None:
    """
    Evaluate sample error-correction cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "error_correction_cases.csv"
    output_path = article_dir / "data" / "computed_bit_flip_code_syndromes.csv"

    cases = pd.read_csv(input_path)

    rows = []

    for _, row in cases.iterrows():
        syndrome = syndrome_for_bits(row["physical_state"])
        rows.append(
            {
                "case_id": row["case_id"],
                "physical_state": row["physical_state"],
                "computed_syndrome": syndrome,
                "expected_syndrome": row["expected_syndrome"],
                "suggested_correction": correction_from_syndrome(syndrome),
                "matches_expected": syndrome == row["expected_syndrome"],
            }
        )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Three-qubit bit-flip code syndrome table:")
    print(table.to_string(index=False))


if __name__ == "__main__":
    main()
