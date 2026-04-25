"""
Simplified BCS Gap Scaffold

Uses a common approximate weak-coupling temperature dependence:

    Delta(T) ≈ Delta_0 tanh(1.74 sqrt(Tc/T - 1))

with:
    Delta_0 ≈ 1.764 k_B Tc
"""

from pathlib import Path

import numpy as np
import pandas as pd


def run_case(case: pd.Series, k_b_j_k: float) -> pd.DataFrame:
    """
    Generate BCS gap table for one critical temperature.
    """
    tc = float(case["critical_temperature_k"])
    temperatures = np.linspace(0.001 * tc, 0.999 * tc, int(case["n_points"]))
    delta_0 = 1.764 * k_b_j_k * tc

    gap = delta_0 * np.tanh(1.74 * np.sqrt(tc / temperatures - 1.0))

    return pd.DataFrame(
        {
            "case_id": case["case_id"],
            "temperature_k": temperatures,
            "critical_temperature_k": tc,
            "delta_j": gap,
            "delta_0_j": delta_0,
            "delta_over_delta0": gap / delta_0,
            "notes": case["notes"],
        }
    )


def main() -> None:
    """
    Generate simplified BCS gap tables.
    """
    article_dir = Path(__file__).resolve().parents[1]

    constants = pd.read_csv(article_dir / "data" / "constants.csv")
    k_b = float(constants.loc[constants["constant_name"] == "boltzmann_constant", "value"].iloc[0])

    cases = pd.read_csv(article_dir / "data" / "bcs_gap_cases.csv")
    output = pd.concat([run_case(case, k_b) for _, case in cases.iterrows()], ignore_index=True)

    output.to_csv(article_dir / "data" / "computed_bcs_gap_scaffold.csv", index=False)

    print("BCS gap scaffold sample:")
    print(output.groupby("case_id").head(6).to_string(index=False))


if __name__ == "__main__":
    main()
