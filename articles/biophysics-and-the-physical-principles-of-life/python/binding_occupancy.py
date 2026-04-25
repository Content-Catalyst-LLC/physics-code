"""
Binding Occupancy

This workflow computes simple one-site binding occupancy:

    theta = [L]/(KD + [L])
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Generate binding occupancy curves for sample KD values.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "binding_cases.csv"
    output_path = article_dir / "data" / "computed_binding_occupancy.csv"
    summary_path = article_dir / "data" / "computed_binding_occupancy_summary.csv"

    cases = pd.read_csv(input_path)
    frames = []

    for _, row in cases.iterrows():
        ligand_concentration = np.logspace(
            np.log10(row["ligand_min_m"]),
            np.log10(row["ligand_max_m"]),
            int(row["n_points"]),
        )

        occupancy = ligand_concentration / (row["kd_m"] + ligand_concentration)

        frames.append(
            pd.DataFrame(
                {
                    "case_id": row["case_id"],
                    "kd_m": row["kd_m"],
                    "ligand_concentration_m": ligand_concentration,
                    "fraction_bound": occupancy,
                    "notes": row["notes"],
                }
            )
        )

    output = pd.concat(frames, ignore_index=True)

    summary = (
        output
        .assign(distance_to_half=lambda df: abs(df["fraction_bound"] - 0.5))
        .sort_values(["case_id", "distance_to_half"])
        .groupby("case_id", as_index=False)
        .first()[["case_id", "kd_m", "ligand_concentration_m", "fraction_bound"]]
        .rename(columns={"ligand_concentration_m": "approx_half_occupancy_ligand_m"})
    )

    output.to_csv(output_path, index=False)
    summary.to_csv(summary_path, index=False)

    print("Binding occupancy sample:")
    print(output.groupby("case_id").head(5).round(8).to_string(index=False))

    print("\nHalf-occupancy summary:")
    print(summary.round(12).to_string(index=False))


if __name__ == "__main__":
    main()
