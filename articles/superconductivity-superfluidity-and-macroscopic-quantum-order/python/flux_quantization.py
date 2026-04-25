"""
Flux Quantization

Computes superconducting flux states:

    Phi_n = n h/(2e)
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Generate flux quantization tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    constants = pd.read_csv(article_dir / "data" / "constants.csv")
    flux_quantum = float(constants.loc[constants["constant_name"] == "flux_quantum", "value"].iloc[0])

    cases = pd.read_csv(article_dir / "data" / "flux_loop_cases.csv")
    rows = []

    for _, case in cases.iterrows():
        for n in range(int(case["n_min"]), int(case["n_max"]) + 1):
            rows.append(
                {
                    "case_id": case["case_id"],
                    "n": n,
                    "flux_wb": n * flux_quantum,
                    "flux_quantum_wb": flux_quantum,
                    "notes": case["notes"],
                }
            )

    output = pd.DataFrame(rows)
    output.to_csv(article_dir / "data" / "computed_flux_quantization.csv", index=False)

    print("Flux quantization table:")
    print(output.to_string(index=False))


if __name__ == "__main__":
    main()
