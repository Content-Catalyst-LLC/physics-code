"""
Dimensional Analysis Scaffold

This workflow stores dimensions as exponent vectors over base dimensions:

    M = mass
    L = length
    T = time

It checks selected physical relations for dimensional consistency.
"""

from pathlib import Path

import pandas as pd


Dimension = tuple[int, int, int]


DIMENSIONS: dict[str, Dimension] = {
    "mass": (1, 0, 0),
    "length": (0, 1, 0),
    "time": (0, 0, 1),
    "velocity": (0, 1, -1),
    "acceleration": (0, 1, -2),
    "force": (1, 1, -2),
    "energy": (1, 2, -2),
    "power": (1, 2, -3),
    "pressure": (1, -1, -2),
    "diffusion": (0, 2, -1),
}


def multiply(a: Dimension, b: Dimension) -> Dimension:
    """
    Multiply dimensions by adding exponents.
    """
    return tuple(x + y for x, y in zip(a, b))


def divide(a: Dimension, b: Dimension) -> Dimension:
    """
    Divide dimensions by subtracting exponents.
    """
    return tuple(x - y for x, y in zip(a, b))


def power(a: Dimension, exponent: int) -> Dimension:
    """
    Raise dimension to an integer power.
    """
    return tuple(exponent * x for x in a)


def main() -> None:
    """
    Check a small catalog of dimensional relations.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_dimensional_consistency.csv"

    checks = [
        {
            "relation": "velocity = length / time",
            "left": DIMENSIONS["velocity"],
            "right": divide(DIMENSIONS["length"], DIMENSIONS["time"]),
        },
        {
            "relation": "acceleration = velocity / time",
            "left": DIMENSIONS["acceleration"],
            "right": divide(DIMENSIONS["velocity"], DIMENSIONS["time"]),
        },
        {
            "relation": "force = mass * acceleration",
            "left": DIMENSIONS["force"],
            "right": multiply(DIMENSIONS["mass"], DIMENSIONS["acceleration"]),
        },
        {
            "relation": "energy = mass * velocity^2",
            "left": DIMENSIONS["energy"],
            "right": multiply(DIMENSIONS["mass"], power(DIMENSIONS["velocity"], 2)),
        },
        {
            "relation": "pressure = force / length^2",
            "left": DIMENSIONS["pressure"],
            "right": divide(DIMENSIONS["force"], power(DIMENSIONS["length"], 2)),
        },
    ]

    table = pd.DataFrame(
        {
            "relation": item["relation"],
            "left_dimension_M_L_T": str(item["left"]),
            "right_dimension_M_L_T": str(item["right"]),
            "is_consistent": item["left"] == item["right"],
        }
        for item in checks
    )

    table.to_csv(output_path, index=False)

    print("Dimensional consistency checks:")
    print(table.to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()
