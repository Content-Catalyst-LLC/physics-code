"""
Angular-Momentum Matrices for SU(2)

This workflow constructs spin-j angular-momentum matrices and verifies:

    [J_x, J_y] = i hbar J_z
    J^2 = hbar^2 j(j+1) I
"""

from pathlib import Path

import numpy as np
import pandas as pd


def angular_momentum_matrices(j: float, hbar: float = 1.0) -> dict:
    """
    Construct spin-j angular-momentum matrices.
    """
    dimension = int(2 * j + 1)
    m_values = np.array([j - index for index in range(dimension)], dtype=float)

    j_plus = np.zeros((dimension, dimension), dtype=complex)
    j_minus = np.zeros((dimension, dimension), dtype=complex)
    j_z = np.diag(hbar * m_values).astype(complex)

    m_to_index = {m: index for index, m in enumerate(m_values)}

    for col_index, m in enumerate(m_values):
        raised_m = m + 1
        lowered_m = m - 1

        if raised_m in m_to_index:
            row_index = m_to_index[raised_m]
            coefficient = hbar * np.sqrt(j * (j + 1) - m * (m + 1))
            j_plus[row_index, col_index] = coefficient

        if lowered_m in m_to_index:
            row_index = m_to_index[lowered_m]
            coefficient = hbar * np.sqrt(j * (j + 1) - m * (m - 1))
            j_minus[row_index, col_index] = coefficient

    j_x = 0.5 * (j_plus + j_minus)
    j_y = (j_plus - j_minus) / (2.0j)

    return {
        "m_values": m_values,
        "J_plus": j_plus,
        "J_minus": j_minus,
        "J_x": j_x,
        "J_y": j_y,
        "J_z": j_z,
    }


def summarize_case(case: pd.Series) -> dict:
    """
    Summarize SU(2) representation diagnostics for one spin value.
    """
    j = float(case["j"])
    hbar = float(case["hbar_convention"])

    matrices = angular_momentum_matrices(j, hbar)

    j_x = matrices["J_x"]
    j_y = matrices["J_y"]
    j_z = matrices["J_z"]

    commutator_xy = j_x @ j_y - j_y @ j_x
    expected_xy = 1j * hbar * j_z

    casimir = j_x @ j_x + j_y @ j_y + j_z @ j_z
    expected_casimir = hbar**2 * j * (j + 1) * np.eye(int(2 * j + 1))

    return {
        "case_id": case["case_id"],
        "j": j,
        "dimension": int(2 * j + 1),
        "commutator_xy_error_norm": float(np.linalg.norm(commutator_xy - expected_xy)),
        "casimir_error_norm": float(np.linalg.norm(casimir - expected_casimir)),
        "casimir_eigenvalue_expected": hbar**2 * j * (j + 1),
        "notes": case["notes"],
    }


def main() -> None:
    """
    Run angular-momentum diagnostics for configured cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "angular_momentum_cases.csv"
    output_path = article_dir / "data" / "computed_su2_angular_momentum_diagnostics.csv"

    cases = pd.read_csv(input_path)
    summary = pd.DataFrame([summarize_case(case) for _, case in cases.iterrows()])

    summary.to_csv(output_path, index=False)

    print("SU(2) angular-momentum representation diagnostics:")
    print(summary.round(12).to_string(index=False))


if __name__ == "__main__":
    main()
