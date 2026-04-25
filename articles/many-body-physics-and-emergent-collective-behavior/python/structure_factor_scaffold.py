"""
Static Structure Factor Scaffold

This workflow computes a 1D structure factor:

    S(q) = (1/N) sum_ij exp(i q (r_i - r_j)) <O_i O_j>

using toy spin configurations.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def structure_factor(spins: np.ndarray) -> pd.DataFrame:
    """
    Compute structure factor for a 1D spin configuration.
    """
    n_sites = len(spins)
    positions = np.arange(n_sites)
    q_values = 2.0 * np.pi * np.arange(n_sites) / n_sites

    rows = []

    for q in q_values:
        total = 0.0 + 0.0j

        for i in range(n_sites):
            for j in range(n_sites):
                total += np.exp(1j * q * (positions[i] - positions[j])) * spins[i] * spins[j]

        rows.append(
            {
                "q": q,
                "structure_factor": float(np.real(total) / n_sites),
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Generate structure-factor examples.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_structure_factor_scaffold.csv"

    configurations = {
        "ferromagnetic": np.ones(32, dtype=int),
        "antiferromagnetic": np.array([1 if i % 2 == 0 else -1 for i in range(32)]),
        "domain_wall": np.array([1] * 16 + [-1] * 16),
    }

    frames = []

    for name, spins in configurations.items():
        table = structure_factor(spins)
        table["configuration"] = name
        frames.append(table)

    output = pd.concat(frames, ignore_index=True)
    output.to_csv(output_path, index=False)

    print("Structure factor scaffold:")
    print(output.groupby("configuration").head(8).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
