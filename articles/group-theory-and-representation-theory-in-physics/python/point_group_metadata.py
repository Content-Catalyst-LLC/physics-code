"""
Point Group Metadata

This workflow reads point-group examples and creates a simple
classification table for physics use cases.
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Summarize point-group examples.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "point_group_examples.csv"
    output_path = article_dir / "data" / "computed_point_group_metadata_summary.csv"

    data = pd.read_csv(input_path)

    summary = data.assign(
        has_high_order=lambda df: df["order_value"] >= 12,
        likely_solid_state_relevance=lambda df: df["common_physics_uses"].str.contains(
            "band|crystal|superconducting|lattice",
            case=False,
            regex=True,
        ),
    )

    summary.to_csv(output_path, index=False)

    print("Point group metadata summary:")
    print(summary.to_string(index=False))


if __name__ == "__main__":
    main()
