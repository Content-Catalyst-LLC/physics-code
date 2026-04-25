"""
Kitaev Chain Diagnostics

For the idealized Kitaev chain, the topological regime is:

    |mu| < 2 |t|

for nonzero pairing under the simplest assumptions.

This workflow labels configured cases.
"""

from pathlib import Path

import pandas as pd


def classify_case(mu: float, hopping: float, pairing: float) -> str:
    """
    Classify idealized Kitaev-chain topological regime.
    """
    if pairing == 0:
        return "gapless_or_unpaired_limit"

    if abs(mu) < 2.0 * abs(hopping):
        return "topological_scaffold"

    if abs(mu) == 2.0 * abs(hopping):
        return "transition_scaffold"

    return "trivial_scaffold"


def main() -> None:
    """
    Classify Kitaev-chain parameter cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "kitaev_chain_cases.csv")

    output = cases.copy()
    output["phase_label"] = [
        classify_case(
            mu=float(row["chemical_potential"]),
            hopping=float(row["hopping"]),
            pairing=float(row["pairing"]),
        )
        for _, row in output.iterrows()
    ]

    output.to_csv(article_dir / "data" / "computed_kitaev_chain_diagnostics.csv", index=False)

    print("Kitaev chain diagnostics:")
    print(output.to_string(index=False))


if __name__ == "__main__":
    main()
