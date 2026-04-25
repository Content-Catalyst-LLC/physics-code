"""
Bloch Vector Diagnostics

For a single qubit density matrix:

    rho = 1/2 (I + r_x sigma_x + r_y sigma_y + r_z sigma_z)

the Bloch vector components are:

    r_i = Tr(rho sigma_i)
"""

from pathlib import Path

import numpy as np
import pandas as pd


SIGMA_X = np.array([[0.0, 1.0], [1.0, 0.0]], dtype=np.complex128)
SIGMA_Y = np.array([[0.0, -1.0j], [1.0j, 0.0]], dtype=np.complex128)
SIGMA_Z = np.array([[1.0, 0.0], [0.0, -1.0]], dtype=np.complex128)


def normalize_state(state: np.ndarray) -> np.ndarray:
    """
    Normalize a qubit state vector.
    """
    norm = np.sqrt(np.vdot(state, state).real)
    if norm == 0.0:
        raise ValueError("Cannot normalize zero vector.")
    return state / norm


def density_matrix_from_state(state: np.ndarray) -> np.ndarray:
    """
    Construct pure-state density matrix.
    """
    return np.outer(state, np.conjugate(state))


def bloch_vector(rho: np.ndarray) -> tuple[float, float, float]:
    """
    Compute Bloch vector components.
    """
    rx = np.trace(rho @ SIGMA_X).real
    ry = np.trace(rho @ SIGMA_Y).real
    rz = np.trace(rho @ SIGMA_Z).real
    return rx, ry, rz


def main() -> None:
    """
    Compute Bloch diagnostics for sample qubit states.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "qubit_state_cases.csv"
    output_path = article_dir / "data" / "computed_bloch_vector_diagnostics.csv"

    cases = pd.read_csv(input_path)

    rows = []

    for _, row in cases.iterrows():
        state = np.array(
            [
                row["alpha_real"] + 1j * row["alpha_imag"],
                row["beta_real"] + 1j * row["beta_imag"],
            ],
            dtype=np.complex128,
        )

        state = normalize_state(state)
        rho = density_matrix_from_state(state)
        rx, ry, rz = bloch_vector(rho)

        rows.append(
            {
                "case_id": row["case_id"],
                "bloch_x": rx,
                "bloch_y": ry,
                "bloch_z": rz,
                "bloch_radius": np.sqrt(rx**2 + ry**2 + rz**2),
                "purity": np.trace(rho @ rho).real,
                "probability_zero": abs(state[0]) ** 2,
                "probability_one": abs(state[1]) ** 2,
            }
        )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Bloch vector diagnostics:")
    print(table.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
