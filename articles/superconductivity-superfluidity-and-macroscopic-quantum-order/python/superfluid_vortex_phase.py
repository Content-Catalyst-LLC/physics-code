"""
Superfluid Vortex Phase Field

For a vortex with winding number n:

    theta(x, y) = n atan2(y, x)

This workflow generates a grid of phase values.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Generate phase field for one vortex case.
    """
    grid_size = int(case["grid_size"])
    domain_min = float(case["domain_min"])
    domain_max = float(case["domain_max"])
    winding = int(case["winding_number"])

    xs = np.linspace(domain_min, domain_max, grid_size)
    ys = np.linspace(domain_min, domain_max, grid_size)

    rows = []

    for x in xs:
        for y in ys:
            radius = np.sqrt(x**2 + y**2)
            phase = winding * np.arctan2(y, x)

            rows.append(
                {
                    "case_id": case["case_id"],
                    "x": x,
                    "y": y,
                    "radius": radius,
                    "winding_number": winding,
                    "phase": phase,
                    "notes": case["notes"],
                }
            )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Generate vortex phase-field tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "vortex_cases.csv")

    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)
    output.to_csv(article_dir / "data" / "computed_vortex_phase_fields.csv", index=False)

    print("Vortex phase-field sample:")
    print(output.groupby("case_id").head(5).round(6).to_string(index=False))


if __name__ == "__main__":
    main()
