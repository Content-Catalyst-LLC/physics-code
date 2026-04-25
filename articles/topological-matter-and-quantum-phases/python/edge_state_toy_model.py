"""
Edge-State Toy Model Metadata

This scaffold does not diagonalize a full open-boundary Hamiltonian.
It records expected edge-state logic for canonical topological models.
"""

from pathlib import Path

import pandas as pd


def main() -> None:
    """
    Create edge-state expectation table from phase examples.
    """
    article_dir = Path(__file__).resolve().parents[1]
    phases = pd.read_csv(article_dir / "data" / "topological_phase_examples.csv")

    output = phases.assign(
        boundary_keyword=phases["signature"].str.extract(
            r"(edge states|surface Dirac states|Majorana end modes|chiral edge states|helical edge states)",
            expand=False,
        )
    )

    output.to_csv(article_dir / "data" / "computed_edge_state_toy_metadata.csv", index=False)

    print("Edge-state toy metadata:")
    print(output.to_string(index=False))


if __name__ == "__main__":
    main()
