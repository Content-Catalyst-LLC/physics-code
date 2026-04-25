"""
Generating Functional Scaffold

For a two-variable Gaussian source model:

    Z[J] = exp(1/2 J^T G J)

This workflow evaluates Z[J] and the scaffolded two-point kernel.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def evaluate_case(case: pd.Series) -> dict:
    """
    Evaluate a simple two-source Gaussian generating functional.
    """
    g_value = float(case["propagator_value"])
    kernel = np.array([[1.0, g_value], [g_value, 1.0]], dtype=float)
    source = np.array([float(case["source_j1"]), float(case["source_j2"])])

    exponent = 0.5 * float(source.T @ kernel @ source)
    z_value = float(np.exp(exponent))

    return {
        "case_id": case["case_id"],
        "propagator_value": g_value,
        "source_j1": source[0],
        "source_j2": source[1],
        "exponent": exponent,
        "z_value": z_value,
        "two_point_kernel_12": kernel[0, 1],
        "notes": case["notes"],
    }


def main() -> None:
    """
    Evaluate generating-functional scaffold cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "generating_functional_cases.csv"
    output_path = article_dir / "data" / "computed_generating_functional_scaffold.csv"

    cases = pd.read_csv(input_path)
    output = pd.DataFrame([evaluate_case(case) for _, case in cases.iterrows()])

    output.to_csv(output_path, index=False)

    print("Generating functional scaffold:")
    print(output.round(10).to_string(index=False))


if __name__ == "__main__":
    main()
