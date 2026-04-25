"""
Gaussian Integral Diagnostics

For a positive definite 2D matrix A and source J:

    Integral d^n x exp(-1/2 x^T A x + J^T x)
      = sqrt((2 pi)^n / det(A)) exp(1/2 J^T A^-1 J)

This workflow evaluates the analytic expression for configured cases.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def evaluate_case(case: pd.Series) -> dict:
    """
    Evaluate a two-dimensional Gaussian integral diagnostic.
    """
    a_matrix = np.array(
        [
            [float(case["a11"]), float(case["a12"])],
            [float(case["a12"]), float(case["a22"])],
        ]
    )
    j_vector = np.array([float(case["j1"]), float(case["j2"])])

    determinant = float(np.linalg.det(a_matrix))
    inverse = np.linalg.inv(a_matrix)
    exponent = 0.5 * float(j_vector.T @ inverse @ j_vector)
    normalization = np.sqrt((2.0 * np.pi) ** 2 / determinant)
    integral_value = normalization * np.exp(exponent)

    return {
        "case_id": case["case_id"],
        "determinant": determinant,
        "source_exponent": exponent,
        "normalization": normalization,
        "integral_value": integral_value,
        "is_positive_definite": bool(np.all(np.linalg.eigvalsh(a_matrix) > 0.0)),
        "notes": case["notes"],
    }


def main() -> None:
    """
    Evaluate Gaussian integral diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "gaussian_integral_cases.csv"
    output_path = article_dir / "data" / "computed_gaussian_integral_diagnostics.csv"

    cases = pd.read_csv(input_path)
    output = pd.DataFrame([evaluate_case(case) for _, case in cases.iterrows()])

    output.to_csv(output_path, index=False)

    print("Gaussian integral diagnostics:")
    print(output.round(10).to_string(index=False))


if __name__ == "__main__":
    main()
