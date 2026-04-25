"""
Finite Difference Convergence Study

Tests the central difference approximation:

    u'(x) ≈ [u(x + dx) - u(x - dx)] / (2 dx)

for smooth functions with known exact derivatives.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def evaluate_case(case: pd.Series) -> pd.DataFrame:
    """
    Compute derivative error and observed convergence order for one case.
    """
    target_x = float(case["target_x"])
    powers = np.arange(int(case["dx_power_min"]), int(case["dx_power_max"]) - 1, -1)
    dx_values = 2.0 ** powers

    if "cos" in case["case_id"]:
        function = np.cos
        exact_derivative = -np.sin(target_x)
    else:
        function = np.sin
        exact_derivative = np.cos(target_x)

    numeric_derivative = (function(target_x + dx_values) - function(target_x - dx_values)) / (2.0 * dx_values)
    absolute_error = np.abs(numeric_derivative - exact_derivative)

    observed_order = np.full_like(dx_values, fill_value=np.nan, dtype=float)
    observed_order[1:] = np.log(absolute_error[:-1] / absolute_error[1:]) / np.log(dx_values[:-1] / dx_values[1:])

    return pd.DataFrame(
        {
            "case_id": case["case_id"],
            "target_x": target_x,
            "dx": dx_values,
            "numeric_derivative": numeric_derivative,
            "exact_derivative": exact_derivative,
            "absolute_error": absolute_error,
            "observed_order": observed_order,
            "notes": case["notes"],
        }
    )


def main() -> None:
    """
    Run all derivative convergence cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "derivative_convergence_cases.csv")

    output = pd.concat([evaluate_case(case) for _, case in cases.iterrows()], ignore_index=True)
    output.to_csv(article_dir / "data" / "computed_finite_difference_convergence.csv", index=False)

    print("Finite difference convergence sample:")
    print(output.groupby("case_id").head(8).to_string(index=False))


if __name__ == "__main__":
    main()
