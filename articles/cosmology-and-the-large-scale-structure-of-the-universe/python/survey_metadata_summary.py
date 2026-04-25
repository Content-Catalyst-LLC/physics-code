"""
Survey Metadata Summary

This workflow summarizes survey observables and tracer categories for
cosmology and large-scale-structure context.
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Summarize survey metadata.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "survey_metadata.csv"
    output_path = article_dir / "data" / "computed_survey_metadata_summary.csv"

    surveys = pd.read_csv(input_path)

    summary = surveys.assign(
        includes_lensing=lambda df: df["primary_observables"].str.contains(
            "lensing", case=False, regex=False
        ),
        includes_bao=lambda df: df["primary_observables"].str.contains(
            "BAO", case=False, regex=False
        )
        | df["cosmological_role"].str.contains("BAO", case=False, regex=False),
        probes_dark_energy=lambda df: df["cosmological_role"].str.contains(
            "dark energy", case=False, regex=False
        ),
    )

    summary.to_csv(output_path, index=False)

    print("Survey metadata summary:")
    print(summary.to_string(index=False))


if __name__ == "__main__":
    main()
