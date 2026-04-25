"""
Correlation Function Scaffold

This workflow evaluates a common critical correlation form:

    G(r) ~ exp(-r/xi) / r^(d - 2 + eta)

for selected correlation lengths.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Generate correlation-function diagnostic table.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_correlation_function_scaffold.csv"

    distances = np.arange(1, 65)
    correlation_lengths = [2, 4, 8, 16, 32]
    dimension = 2
    eta = 0.25

    rows = []

    for xi in correlation_lengths:
        for r in distances:
            g_r = np.exp(-r / xi) / (r ** (dimension - 2 + eta))
            rows.append(
                {
                    "distance_r": r,
                    "correlation_length_xi": xi,
                    "dimension": dimension,
                    "eta": eta,
                    "correlation_value": g_r,
                }
            )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Correlation-function scaffold:")
    print(output.groupby("correlation_length_xi").head(5).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
