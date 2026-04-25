"""
Band-Gap Classifier

This workflow classifies materials using simplified band-gap thresholds.

This is a conceptual scaffold. Real material classification depends on
band structure, temperature, disorder, carrier density, measurement method,
surface states, dimensionality, and many other factors.
"""

from pathlib import Path

import pandas as pd


def classify_band_gap(band_gap_ev: float) -> str:
    """
    Classify a material using simplified band-gap thresholds.

    Parameters
    ----------
    band_gap_ev:
        Band gap in electron volts.

    Returns
    -------
    str
        Simplified class label.
    """
    if band_gap_ev <= 0.05:
        return "metal_or_semimetal_like"
    if band_gap_ev < 3.0:
        return "semiconductor_like"
    return "insulator_like"


def main() -> None:
    """
    Load sample band gaps and apply simplified classification.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "material_band_gap_sample.csv"
    output_path = article_dir / "data" / "computed_band_gap_classification.csv"

    materials = pd.read_csv(input_path)
    materials["simplified_classification"] = materials["band_gap_ev"].apply(classify_band_gap)

    materials.to_csv(output_path, index=False)

    print("Band-gap classification table:")
    print(materials.to_string(index=False))
    print(f"\nSaved classification table to: {output_path}")


if __name__ == "__main__":
    main()
