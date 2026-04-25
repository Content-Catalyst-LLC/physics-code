"""
Michaelis-Menten Kinetics

This workflow computes:

    v = Vmax [S]/(KM + [S])
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Generate Michaelis-Menten kinetic curves for sample enzyme cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "enzyme_kinetic_cases.csv"
    output_path = article_dir / "data" / "computed_michaelis_menten_kinetics.csv"

    cases = pd.read_csv(input_path)
    frames = []

    for _, row in cases.iterrows():
        substrate = np.linspace(
            row["substrate_min_uM"],
            row["substrate_max_uM"],
            int(row["n_points"]),
        )

        rate = row["vmax_uM_s"] * substrate / (row["km_uM"] + substrate)

        frames.append(
            pd.DataFrame(
                {
                    "case_id": row["case_id"],
                    "substrate_uM": substrate,
                    "rate_uM_s": rate,
                    "vmax_uM_s": row["vmax_uM_s"],
                    "km_uM": row["km_uM"],
                    "notes": row["notes"],
                }
            )
        )

    output = pd.concat(frames, ignore_index=True)
    output.to_csv(output_path, index=False)

    print("Michaelis-Menten kinetics sample:")
    print(output.groupby("case_id").head(6).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
