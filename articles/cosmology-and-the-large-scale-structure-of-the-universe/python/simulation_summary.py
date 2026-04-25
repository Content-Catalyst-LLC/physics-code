"""
Simulation Metadata Summary

This workflow summarizes cosmological simulation suites by method and role.
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Summarize simulation metadata.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "simulation_metadata.csv"
    output_path = article_dir / "data" / "computed_simulation_metadata_summary.csv"

    simulations = pd.read_csv(input_path)

    summary = simulations.assign(
        includes_baryons=lambda df: df["method"].str.contains(
            "hydro|magnetohydrodynamic", case=False, regex=True
        ),
        supports_mock_catalogs=lambda df: df["primary_outputs"].str.contains(
            "mock|catalog", case=False, regex=True
        ),
        precision_survey_use=lambda df: df["cosmological_use"].str.contains(
            "survey|inference|covariance", case=False, regex=True
        ),
    )

    summary.to_csv(output_path, index=False)

    print("Simulation metadata summary:")
    print(summary.to_string(index=False))


if __name__ == "__main__":
    main()
