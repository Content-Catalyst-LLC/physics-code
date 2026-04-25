"""
Lie Algebra Commutators

This workflow computes SU(2) commutators using Pauli matrices.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def commutator(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    """
    Compute matrix commutator [A, B] = AB - BA.
    """
    return a @ b - b @ a


def main() -> None:
    """
    Compute SU(2) Pauli-matrix commutator diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_su2_commutator_diagnostics.csv"

    sigma_x = np.array([[0, 1], [1, 0]], dtype=complex)
    sigma_y = np.array([[0, -1j], [1j, 0]], dtype=complex)
    sigma_z = np.array([[1, 0], [0, -1]], dtype=complex)

    cases = [
        ("sigma_x", "sigma_y", sigma_x, sigma_y, 2j * sigma_z),
        ("sigma_y", "sigma_z", sigma_y, sigma_z, 2j * sigma_x),
        ("sigma_z", "sigma_x", sigma_z, sigma_x, 2j * sigma_y),
    ]

    rows = []

    for name_a, name_b, matrix_a, matrix_b, expected in cases:
        observed = commutator(matrix_a, matrix_b)

        rows.append(
            {
                "generator_a": name_a,
                "generator_b": name_b,
                "expected_relation": "2 i epsilon_abc sigma_c",
                "error_norm": float(np.linalg.norm(observed - expected)),
            }
        )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("SU(2) commutator diagnostics:")
    print(output.round(12).to_string(index=False))


if __name__ == "__main__":
    main()
