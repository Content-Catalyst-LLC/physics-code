"""
Wick-Style Contraction Metadata

This workflow stores simple contraction-count metadata for even numbers
of fields in a Gaussian/free-field theory.

For 2n fields, the number of pairings is:

    (2n - 1)!!

This is metadata scaffolding, not a symbolic Wick theorem engine.
"""

from pathlib import Path

import math
import pandas as pd


def double_factorial_odd(n: int) -> int:
    """
    Compute n!! for odd n >= -1, with (-1)!! = 1.
    """
    if n == -1 or n == 0:
        return 1

    result = 1

    for value in range(n, 0, -2):
        result *= value

    return result


def main() -> None:
    """
    Save contraction-count metadata for 2, 4, 6, 8, and 10 fields.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_wick_contraction_metadata.csv"

    rows = []

    for n_pairs in range(1, 6):
        n_fields = 2 * n_pairs
        pairings = double_factorial_odd(n_fields - 1)

        rows.append(
            {
                "n_fields": n_fields,
                "n_pairs": n_pairs,
                "number_of_pairings": pairings,
                "formula": "(2n - 1)!!",
                "notes": "Free Gaussian field contraction-count scaffold.",
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Wick-style contraction metadata:")
    print(output.to_string(index=False))


if __name__ == "__main__":
    main()
