"""
Representation Check for C3

This workflow verifies that a rotation representation of C3 satisfies:

    D(gh) = D(g)D(h)
"""

from pathlib import Path

import numpy as np
import pandas as pd


def rotation_matrix(theta: float) -> np.ndarray:
    """
    Construct a 2D rotation matrix.
    """
    return np.array(
        [
            [np.cos(theta), -np.sin(theta)],
            [np.sin(theta), np.cos(theta)],
        ],
        dtype=float,
    )


def main() -> None:
    """
    Verify multiplication closure for a 2D real representation of C3.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_c3_representation_check.csv"

    matrices = {
        "e": rotation_matrix(0.0),
        "r": rotation_matrix(2.0 * np.pi / 3.0),
        "r2": rotation_matrix(4.0 * np.pi / 3.0),
    }

    multiplication = {
        ("e", "e"): "e",
        ("e", "r"): "r",
        ("e", "r2"): "r2",
        ("r", "e"): "r",
        ("r", "r"): "r2",
        ("r", "r2"): "e",
        ("r2", "e"): "r2",
        ("r2", "r"): "e",
        ("r2", "r2"): "r",
    }

    rows = []

    for (a, b), product in multiplication.items():
        left = matrices[a] @ matrices[b]
        right = matrices[product]

        rows.append(
            {
                "element_a": a,
                "element_b": b,
                "product": product,
                "error_norm": float(np.linalg.norm(left - right)),
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("C3 representation check:")
    print(output.round(12).to_string(index=False))


if __name__ == "__main__":
    main()
