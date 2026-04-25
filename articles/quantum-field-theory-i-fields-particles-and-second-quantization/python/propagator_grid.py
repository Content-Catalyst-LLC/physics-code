"""
Scalar Propagator Grid

This workflow evaluates a simple momentum-space scalar propagator:

    Delta_F(p) = i / (p^2 - m^2 + i epsilon)

It stores real and imaginary parts across a grid of p^2 values.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Evaluate propagator grids for sample cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "propagator_cases.csv"
    output_path = article_dir / "data" / "computed_scalar_propagator_grid.csv"

    cases = pd.read_csv(input_path)
    frames = []

    for _, case in cases.iterrows():
        p2_values = np.linspace(case["p2_min"], case["p2_max"], int(case["n_points"]))
        denominator = p2_values - case["mass_natural"] ** 2 + 1j * case["epsilon"]
        propagator = 1j / denominator

        frames.append(
            pd.DataFrame(
                {
                    "case_id": case["case_id"],
                    "mass_natural": case["mass_natural"],
                    "p2_natural": p2_values,
                    "epsilon": case["epsilon"],
                    "propagator_real": propagator.real,
                    "propagator_imag": propagator.imag,
                    "propagator_abs": np.abs(propagator),
                    "notes": case["notes"],
                }
            )
        )

    output = pd.concat(frames, ignore_index=True)
    output.to_csv(output_path, index=False)

    print("Scalar propagator grid sample:")
    print(output.groupby("case_id").head(6).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
