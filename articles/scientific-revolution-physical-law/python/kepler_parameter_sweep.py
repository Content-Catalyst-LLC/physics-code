"""
Kepler-Style Parameter Sweep

This script generates a smooth parameter sweep for the relation:

    T = a^(3/2)

where:
    a = semi-major axis in normalized units
    T = orbital period in normalized units

The output can be used for plotting, teaching, regression, or database ingestion.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "kepler_parameter_sweep.csv"

    semi_major_axis_normalized = np.linspace(0.25, 10.0, 400)
    orbital_period_normalized = semi_major_axis_normalized ** 1.5

    sweep = pd.DataFrame(
        {
            "semi_major_axis_normalized": semi_major_axis_normalized,
            "orbital_period_normalized": orbital_period_normalized,
        }
    )

    sweep.to_csv(output_path, index=False)

    print(sweep.head().round(6).to_string(index=False))
    print(f"\nSaved parameter sweep to: {output_path}")


if __name__ == "__main__":
    main()
