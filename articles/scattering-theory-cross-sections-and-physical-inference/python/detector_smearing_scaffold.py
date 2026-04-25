"""
Detector Smearing Scaffold

Generates a simple true resonance spectrum and smears the measured energy by
a fractional Gaussian resolution.

This is not a full detector simulation.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series, seed_offset: int) -> pd.DataFrame:
    """
    Generate detector-smeared event sample for one detector response case.
    """
    rng = np.random.default_rng(1000 + seed_offset)

    n_events = 5000
    true_energy = rng.normal(loc=1.0, scale=0.06, size=n_events)
    resolution = float(case["energy_resolution_fraction"])

    measured_energy = rng.normal(
        loc=true_energy,
        scale=resolution * np.maximum(true_energy, 1e-6),
    )

    keep_mask = rng.random(n_events) < float(case["efficiency"])

    return pd.DataFrame(
        {
            "case_id": case["case_id"],
            "true_energy": true_energy[keep_mask],
            "measured_energy": measured_energy[keep_mask],
            "energy_resolution_fraction": resolution,
            "efficiency": float(case["efficiency"]),
            "background_level": float(case["background_level"]),
            "notes": case["notes"],
        }
    )


def main() -> None:
    """
    Generate detector-smearing sample tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "detector_response_cases.csv")

    output = pd.concat(
        [run_case(case, index) for index, (_, case) in enumerate(cases.iterrows())],
        ignore_index=True,
    )

    summary = (
        output.groupby("case_id", as_index=False)
        .agg(
            n_selected=("measured_energy", "count"),
            true_energy_mean=("true_energy", "mean"),
            measured_energy_mean=("measured_energy", "mean"),
            measured_energy_sd=("measured_energy", "std"),
        )
    )

    output.to_csv(article_dir / "data" / "computed_detector_smearing_events.csv", index=False)
    summary.to_csv(article_dir / "data" / "computed_detector_smearing_summary.csv", index=False)

    print("Detector smearing summary:")
    print(summary.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
