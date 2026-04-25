"""
Scalar Field Mode Dispersion

For a free scalar field in natural units:

    omega_k = sqrt(k^2 + m^2)
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Generate scalar-field dispersion tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "scalar_field_mode_cases.csv"
    output_path = article_dir / "data" / "computed_scalar_field_modes.csv"

    cases = pd.read_csv(input_path)
    frames = []

    for _, case in cases.iterrows():
        k_values = np.linspace(case["k_min"], case["k_max"], int(case["n_points"]))
        omega = np.sqrt(k_values**2 + case["mass_natural"] ** 2)

        frames.append(
            pd.DataFrame(
                {
                    "case_id": case["case_id"],
                    "mass_natural": case["mass_natural"],
                    "k_natural": k_values,
                    "omega_natural": omega,
                    "group_velocity": np.divide(
                        k_values,
                        omega,
                        out=np.zeros_like(k_values),
                        where=omega != 0,
                    ),
                    "notes": case["notes"],
                }
            )
        )

    output = pd.concat(frames, ignore_index=True)
    output.to_csv(output_path, index=False)

    print("Scalar-field mode dispersion sample:")
    print(output.groupby("case_id").head(6).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
