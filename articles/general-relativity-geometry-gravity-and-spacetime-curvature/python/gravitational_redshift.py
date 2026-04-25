"""
Gravitational Redshift Grid

This workflow computes Schwarzschild redshift factors as a function
of compactness r_s/r.

    1 + z = 1/sqrt(1 - r_s/r)
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Generate a redshift table over compactness values.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_redshift_compactness_grid.csv"

    compactness_values = np.array(
        [1e-9, 1e-8, 1e-6, 1e-4, 1e-2, 0.05, 0.1, 0.2, 0.4, 0.8]
    )

    redshift_factor = 1.0 / np.sqrt(1.0 - compactness_values)

    output = pd.DataFrame(
        {
            "compactness_rs_over_r": compactness_values,
            "redshift_factor_1_plus_z": redshift_factor,
            "gravitational_redshift_z": redshift_factor - 1.0,
        }
    )

    output.to_csv(output_path, index=False)

    print("Gravitational redshift compactness grid:")
    print(output.round(10).to_string(index=False))


if __name__ == "__main__":
    main()
