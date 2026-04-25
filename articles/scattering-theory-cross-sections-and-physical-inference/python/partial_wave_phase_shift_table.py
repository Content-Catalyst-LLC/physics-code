"""
Partial-Wave Phase Shift Table

Uses a toy phase-shift model:

    delta_l = phase_shift_scale * exp(-l(l+1)/(l_max + 1)^2)

and computes partial contributions:

    sigma_l = (4 pi/k^2) (2l+1) sin^2(delta_l)
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series) -> pd.DataFrame:
    """
    Generate partial-wave contribution table for one case.
    """
    k = float(case["k"])
    l_max = int(case["l_max"])
    scale = float(case["phase_shift_scale"])

    rows = []

    for ell in range(l_max + 1):
        phase_shift = scale * np.exp(-ell * (ell + 1.0) / (l_max + 1.0) ** 2)
        partial_cross_section = (4.0 * np.pi / k**2) * (2 * ell + 1) * np.sin(phase_shift) ** 2

        rows.append(
            {
                "case_id": case["case_id"],
                "k": k,
                "ell": ell,
                "phase_shift": phase_shift,
                "partial_cross_section": partial_cross_section,
                "notes": case["notes"],
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Compute partial-wave tables and summaries.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "partial_wave_cases.csv")

    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)

    summary = (
        output.groupby("case_id", as_index=False)
        .agg(
            total_elastic_cross_section=("partial_cross_section", "sum"),
            max_phase_shift=("phase_shift", "max"),
            l_max=("ell", "max"),
        )
    )

    output.to_csv(article_dir / "data" / "computed_partial_wave_phase_shift_table.csv", index=False)
    summary.to_csv(article_dir / "data" / "computed_partial_wave_summary.csv", index=False)

    print("Partial-wave summary:")
    print(summary.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
