"""
Quantum Generators

This workflow records simple finite-dimensional generator matrices
for spin-1/2 rotations.

The Pauli matrices generate SU(2) spin transformations.
"""

from pathlib import Path

import numpy as np
import pandas as pd


HBAR = 1.0


def main() -> None:
    """
    Save Pauli matrix generator diagnostics.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_quantum_generator_diagnostics.csv"

    sigma_x = np.array([[0, 1], [1, 0]], dtype=complex)
    sigma_y = np.array([[0, -1j], [1j, 0]], dtype=complex)
    sigma_z = np.array([[1, 0], [0, -1]], dtype=complex)

    generators = {
        "Sx": 0.5 * HBAR * sigma_x,
        "Sy": 0.5 * HBAR * sigma_y,
        "Sz": 0.5 * HBAR * sigma_z,
    }

    commutator_xy = generators["Sx"] @ generators["Sy"] - generators["Sy"] @ generators["Sx"]

    rows = [
        {
            "case_id": "spin_half_generators",
            "generator": name,
            "trace": np.trace(matrix).real,
            "determinant": np.linalg.det(matrix).real,
            "eigenvalues": ",".join([str(value.real) for value in np.linalg.eigvalsh(matrix)]),
            "notes": "Pauli-based spin generator",
        }
        for name, matrix in generators.items()
    ]

    rows.append(
        {
            "case_id": "commutator_Sx_Sy",
            "generator": "[Sx,Sy]",
            "trace": np.trace(commutator_xy).real,
            "determinant": np.linalg.det(commutator_xy).real,
            "eigenvalues": ",".join([str(value) for value in np.linalg.eigvals(commutator_xy)]),
            "notes": "commutator should equal i hbar Sz under hbar convention",
        }
    )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Quantum generator diagnostics:")
    print(output.to_string(index=False))


if __name__ == "__main__":
    main()
