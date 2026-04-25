"""
Fixed-Point Stability for the Logistic Map

For the logistic map:

    f(x) = r x (1 - x)

fixed points are:

    x* = 0
    x* = 1 - 1/r

A one-dimensional fixed point is stable when:

    |f'(x*)| < 1
"""

from pathlib import Path

import numpy as np
import pandas as pd


def logistic_derivative(r: float, x: float) -> float:
    """
    Derivative of f(x) = r x (1 - x).
    """
    return r * (1.0 - 2.0 * x)


def main() -> None:
    """
    Compute fixed points and stability across sample r values.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_logistic_fixed_point_stability.csv"

    r_values = np.array([0.5, 0.8, 1.2, 2.0, 2.8, 3.0, 3.2, 3.5, 3.9])

    rows = []

    for r in r_values:
        fixed_points = [0.0]

        if r != 0:
            fixed_points.append(1.0 - 1.0 / r)

        for x_star in fixed_points:
            derivative = logistic_derivative(r, x_star)
            rows.append(
                {
                    "r": r,
                    "fixed_point": x_star,
                    "derivative_at_fixed_point": derivative,
                    "absolute_derivative": abs(derivative),
                    "stable": abs(derivative) < 1.0,
                }
            )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Logistic fixed-point stability:")
    print(table.round(8).to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()
