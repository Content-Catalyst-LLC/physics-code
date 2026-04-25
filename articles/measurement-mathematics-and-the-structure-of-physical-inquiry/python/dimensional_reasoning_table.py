"""
Dimensional Reasoning Table

This workflow stores dimension vectors for common physics quantities.

The vector convention is:
    [M, L, T]

Examples:
    velocity     = [0, 1, -1]
    force        = [1, 1, -2]
    energy       = [1, 2, -2]
"""

from pathlib import Path

import pandas as pd


DIMENSIONS = {
    "length": {"symbol": "L", "M": 0, "L": 1, "T": 0, "si_unit": "m"},
    "time": {"symbol": "t", "M": 0, "L": 0, "T": 1, "si_unit": "s"},
    "mass": {"symbol": "m", "M": 1, "L": 0, "T": 0, "si_unit": "kg"},
    "velocity": {"symbol": "v", "M": 0, "L": 1, "T": -1, "si_unit": "m s^-1"},
    "acceleration": {"symbol": "a", "M": 0, "L": 1, "T": -2, "si_unit": "m s^-2"},
    "force": {"symbol": "F", "M": 1, "L": 1, "T": -2, "si_unit": "N"},
    "energy": {"symbol": "E", "M": 1, "L": 2, "T": -2, "si_unit": "J"},
    "power": {"symbol": "P", "M": 1, "L": 2, "T": -3, "si_unit": "W"},
    "frequency": {"symbol": "f", "M": 0, "L": 0, "T": -1, "si_unit": "Hz"},
    "pressure": {"symbol": "p", "M": 1, "L": -1, "T": -2, "si_unit": "Pa"},
}


def main() -> None:
    """
    Create a dimension-vector table for common quantities.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_dimensional_reasoning_table.csv"

    rows = []

    for quantity, metadata in DIMENSIONS.items():
        rows.append(
            {
                "quantity": quantity,
                "symbol": metadata["symbol"],
                "dimension_vector_M_L_T": (
                    f"[{metadata['M']}, {metadata['L']}, {metadata['T']}]"
                ),
                "mass_exponent_M": metadata["M"],
                "length_exponent_L": metadata["L"],
                "time_exponent_T": metadata["T"],
                "si_unit": metadata["si_unit"],
            }
        )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Dimensional reasoning table:")
    print(table.to_string(index=False))
    print(f"\nSaved dimension table to: {output_path}")


if __name__ == "__main__":
    main()
