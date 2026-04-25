"""
Running-Coupling Toy Model

This workflow illustrates scale dependence using a schematic expression:

    g(mu) = g0 / [1 + beta * log(mu / mu0)]

This is not a precision renormalization-group equation. It is only a
transparent computational scaffold for the idea that effective couplings
can depend on energy scale.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def running_coupling(mu_gev: np.ndarray, g0: float, beta: float, mu0_gev: float = 91.1876) -> np.ndarray:
    """
    Compute a schematic running coupling.

    Parameters
    ----------
    mu_gev:
        Energy scale in GeV.
    g0:
        Coupling value at reference scale mu0.
    beta:
        Toy beta coefficient.
    mu0_gev:
        Reference scale in GeV.

    Returns
    -------
    np.ndarray
        Toy running coupling values.
    """
    return g0 / (1.0 + beta * np.log(mu_gev / mu0_gev))


def main() -> None:
    """
    Generate toy running-coupling tables for three schematic sectors.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_running_coupling_toy_model.csv"

    mu_gev = np.logspace(0, 5, 250)

    table = pd.DataFrame(
        {
            "mu_gev": mu_gev,
            "strong_like_coupling": running_coupling(mu_gev, g0=1.2, beta=0.08),
            "weak_like_coupling": running_coupling(mu_gev, g0=0.65, beta=0.015),
            "hypercharge_like_coupling": running_coupling(mu_gev, g0=0.36, beta=-0.01),
        }
    )

    table.to_csv(output_path, index=False)

    print("Toy running-coupling table:")
    print(table.head(12).round(8).to_string(index=False))
    print(f"\nSaved table to: {output_path}")


if __name__ == "__main__":
    main()
