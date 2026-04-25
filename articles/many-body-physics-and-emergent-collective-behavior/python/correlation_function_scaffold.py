"""
Correlation Function Scaffold

This workflow computes simple connected correlations from a classical
spin configuration and saves distance-averaged values.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def connected_correlations(spins: np.ndarray) -> pd.DataFrame:
    """
    Compute distance-averaged connected spin correlations for a 1D chain.
    """
    n_sites = len(spins)
    mean_spin = np.mean(spins)
    rows = []

    for distance in range(n_sites):
        products = []

        for site in range(n_sites):
            products.append(spins[site] * spins[(site + distance) % n_sites])

        rows.append(
            {
                "distance": distance,
                "raw_correlation": float(np.mean(products)),
                "connected_correlation": float(np.mean(products) - mean_spin**2),
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Generate toy connected correlation examples.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_correlation_function_scaffold.csv"

    configurations = {
        "ferromagnetic": np.ones(32, dtype=int),
        "antiferromagnetic": np.array([1 if i % 2 == 0 else -1 for i in range(32)]),
        "domain_wall": np.array([1] * 16 + [-1] * 16),
    }

    frames = []

    for name, spins in configurations.items():
        table = connected_correlations(spins)
        table["configuration"] = name
        frames.append(table)

    output = pd.concat(frames, ignore_index=True)
    output.to_csv(output_path, index=False)

    print("Correlation scaffold:")
    print(output.groupby("configuration").head(8).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
