"""
Symmetry-Breaking Potential Scan

This workflow evaluates three potentials:

1. Reflection-symmetric potential:
       V(x) = x^2

2. Explicitly broken potential:
       V(x) = x^2 + epsilon*x

3. Symmetric double-well potential:
       V(x) = -a*x^2 + b*x^4

The double-well potential is symmetric under x -> -x, but has two
nonzero minima. Selecting one minimum is a simple model of spontaneous
symmetry breaking.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def symmetric_potential(x: np.ndarray) -> np.ndarray:
    """Compute V(x)=x^2."""
    return x**2


def explicitly_broken_potential(x: np.ndarray, epsilon: float) -> np.ndarray:
    """Compute V(x)=x^2 + epsilon*x."""
    return x**2 + epsilon * x


def double_well_potential(x: np.ndarray, a: float, b: float) -> np.ndarray:
    """Compute V(x)=-a*x^2+b*x^4."""
    return -a * x**2 + b * x**4


def main() -> None:
    """
    Generate potential scan tables and approximate minima.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_symmetry_potential_scan.csv"
    minima_output_path = article_dir / "data" / "computed_double_well_minima.csv"

    x = np.linspace(-3.0, 3.0, 2001)
    epsilon = 0.25
    a = 1.0
    b = 0.25

    table = pd.DataFrame(
        {
            "x": x,
            "symmetric_potential": symmetric_potential(x),
            "explicitly_broken_potential": explicitly_broken_potential(x, epsilon),
            "double_well_potential": double_well_potential(x, a, b),
        }
    )

    min_value = table["double_well_potential"].min()
    tolerance = 1e-4

    minima = table.loc[
        (table["double_well_potential"] - min_value).abs() < tolerance,
        ["x", "double_well_potential"],
    ]

    table.to_csv(output_path, index=False)
    minima.to_csv(minima_output_path, index=False)

    print("Approximate double-well minima:")
    print(minima.head(20).to_string(index=False))

    print(f"\nSaved potential scan to: {output_path}")
    print(f"Saved minima table to: {minima_output_path}")


if __name__ == "__main__":
    main()
