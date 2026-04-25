"""
Weak-Field Comparison

This workflow compares the exact Schwarzschild clock-rate factor:

    sqrt(1 - r_s/r)

with the first-order weak-field approximation:

    1 - 0.5*r_s/r

The approximation is useful when r is much larger than r_s.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def exact_clock_factor(radius_over_rs: np.ndarray) -> np.ndarray:
    """
    Compute exact Schwarzschild clock factor in units of r/r_s.
    """
    return np.sqrt(1.0 - 1.0 / radius_over_rs)


def weak_field_clock_factor(radius_over_rs: np.ndarray) -> np.ndarray:
    """
    Compute first-order weak-field approximation.
    """
    return 1.0 - 0.5 / radius_over_rs


def main() -> None:
    """
    Compare exact and weak-field clock factors.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_weak_field_comparison.csv"

    radius_over_rs = np.concatenate(
        [
            np.linspace(1.05, 10.0, 400),
            np.linspace(10.0, 1000.0, 400),
        ]
    )

    exact = exact_clock_factor(radius_over_rs)
    weak = weak_field_clock_factor(radius_over_rs)

    table = pd.DataFrame(
        {
            "radius_over_rs": radius_over_rs,
            "exact_clock_factor": exact,
            "weak_field_clock_factor": weak,
            "absolute_difference": np.abs(exact - weak),
            "relative_difference": np.abs(exact - weak) / exact,
        }
    )

    table.to_csv(output_path, index=False)

    print("Weak-field comparison:")
    print(table.head(12).round(8).to_string(index=False))
    print(f"\nSaved comparison to: {output_path}")


if __name__ == "__main__":
    main()
