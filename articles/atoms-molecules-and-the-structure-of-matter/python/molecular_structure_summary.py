"""
Molecular Structure Summary

This workflow summarizes a small molecular metadata table by geometry and
polarity.

It is a reproducible data-organization scaffold, not a complete molecular
property database.
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Load and summarize molecule metadata.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "molecule_sample.csv"
    output_path = article_dir / "data" / "computed_molecular_structure_summary.csv"

    molecules = pd.read_csv(input_path)

    summary = (
        molecules.groupby(["geometry", "polarity"])
        .agg(
            n_molecules=("molecule", "count"),
            mean_atoms=("atoms", "mean"),
        )
        .reset_index()
        .sort_values(["geometry", "polarity"])
    )

    summary.to_csv(output_path, index=False)

    print("Molecular metadata:")
    print(molecules.to_string(index=False))

    print("\nSummary by geometry and polarity:")
    print(summary.to_string(index=False))

    print(f"\nSaved summary to: {output_path}")


if __name__ == "__main__":
    main()
