"""
Markov Cycle Entropy Production

For a symmetric three-state cycle with clockwise rate k_plus and
counterclockwise rate k_minus, the steady probabilities are uniform.
This workflow computes probability currents and entropy production.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def compute_case(case: pd.Series) -> dict:
    """
    Compute cycle current, affinity, and entropy production.
    """
    k_plus = float(case["k_plus"])
    k_minus = float(case["k_minus"])

    current = (k_plus - k_minus) / 3.0

    if k_plus > 0 and k_minus > 0:
        affinity = 3.0 * np.log(k_plus / k_minus)
        entropy_production = current * affinity
    else:
        affinity = np.nan
        entropy_production = np.nan

    return {
        "case_id": case["case_id"],
        "k_plus": k_plus,
        "k_minus": k_minus,
        "cycle_current": current,
        "cycle_affinity_kb_units": affinity,
        "entropy_production_rate_kb_units": entropy_production,
        "detailed_balance": np.isclose(k_plus, k_minus),
        "notes": case["notes"],
    }


def main() -> None:
    """
    Run entropy-production calculations for configured Markov cycles.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "markov_cycle_cases.csv")

    output = pd.DataFrame([compute_case(case) for _, case in cases.iterrows()])
    output.to_csv(article_dir / "data" / "computed_markov_entropy_production.csv", index=False)

    print("Markov entropy production:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
