"""
Fermionic Anticommutation Example

A single fermionic mode has a two-dimensional Fock space:
    |0>, |1>

The annihilation operator c and creation operator c dagger satisfy:
    {c, c dagger} = I
    c^2 = 0
    (c dagger)^2 = 0
"""

from pathlib import Path

import numpy as np
import pandas as pd


def main() -> None:
    """
    Compute single-mode fermionic operator diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_fermionic_anticommutation.csv"

    c = np.array([[0.0, 1.0], [0.0, 0.0]])
    cdag = c.T

    anticommutator = c @ cdag + cdag @ c
    c_squared = c @ c
    cdag_squared = cdag @ cdag
    number_operator = cdag @ c

    rows = [
        {
            "quantity": "anticommutator_c_cdag_trace",
            "value": np.trace(anticommutator),
            "interpretation": "Trace of identity for two-dimensional single fermion mode.",
        },
        {
            "quantity": "anticommutator_c_cdag_determinant",
            "value": np.linalg.det(anticommutator),
            "interpretation": "Determinant of identity equals one.",
        },
        {
            "quantity": "c_squared_norm",
            "value": np.linalg.norm(c_squared),
            "interpretation": "Fermionic annihilation operator squares to zero.",
        },
        {
            "quantity": "cdag_squared_norm",
            "value": np.linalg.norm(cdag_squared),
            "interpretation": "Fermionic creation operator squares to zero.",
        },
        {
            "quantity": "number_operator_eigenvalues",
            "value": ",".join(str(x) for x in np.linalg.eigvalsh(number_operator)),
            "interpretation": "Single fermionic mode has occupation 0 or 1.",
        },
    ]

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Fermionic anticommutation diagnostics:")
    print(output.to_string(index=False))


if __name__ == "__main__":
    main()
