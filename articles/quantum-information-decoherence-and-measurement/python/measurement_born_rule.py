"""
Measurement and the Born Rule

This workflow computes measurement probabilities:

    p_i = Tr(P_i rho)

for sample qubit states in the Z and X bases.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def normalize_state(state: np.ndarray) -> np.ndarray:
    """
    Normalize a qubit state vector.
    """
    return state / np.sqrt(np.vdot(state, state).real)


def density_matrix(state: np.ndarray) -> np.ndarray:
    """
    Construct pure-state density matrix.
    """
    return np.outer(state, np.conjugate(state))


def projector_from_flat(flat: str) -> np.ndarray:
    """
    Parse a flattened 2x2 real projector matrix.
    """
    values = [float(item) for item in flat.split(",")]
    return np.array(values, dtype=np.complex128).reshape((2, 2))


def main() -> None:
    """
    Compute Born-rule probabilities for sample states and projectors.
    """
    article_dir = Path(__file__).resolve().parents[1]
    state_path = article_dir / "data" / "qubit_state_cases.csv"
    basis_path = article_dir / "data" / "measurement_basis_cases.csv"
    output_path = article_dir / "data" / "computed_born_rule_probabilities.csv"

    states = pd.read_csv(state_path)
    projectors = pd.read_csv(basis_path)

    rows = []

    for _, state_row in states.iterrows():
        state = np.array(
            [
                state_row["alpha_real"] + 1j * state_row["alpha_imag"],
                state_row["beta_real"] + 1j * state_row["beta_imag"],
            ],
            dtype=np.complex128,
        )
        state = normalize_state(state)
        rho = density_matrix(state)

        for _, projector_row in projectors.iterrows():
            projector = projector_from_flat(projector_row["projector_matrix_flat"])
            probability = np.trace(projector @ rho).real

            rows.append(
                {
                    "state_case_id": state_row["case_id"],
                    "basis_name": projector_row["basis_name"],
                    "projector_label": projector_row["projector_label"],
                    "probability": probability,
                }
            )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Born-rule probability table:")
    print(table.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
