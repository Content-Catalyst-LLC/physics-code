"""
Entanglement Entropy Scaffold

This workflow computes bipartite entanglement entropy for selected
small pure states using singular values of the reshaped state vector.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def entropy_from_state(state: np.ndarray, n_left: int, n_total: int) -> float:
    """
    Compute von Neumann entanglement entropy for a bipartition.

    The state is reshaped into left x right dimensions. Singular values
    give Schmidt coefficients.
    """
    dim_left = 2 ** n_left
    dim_right = 2 ** (n_total - n_left)

    matrix = state.reshape((dim_left, dim_right))
    singular_values = np.linalg.svd(matrix, compute_uv=False)
    probabilities = singular_values**2
    probabilities = probabilities[probabilities > 1e-14]

    return float(-np.sum(probabilities * np.log(probabilities)))


def make_product_state(n_total: int) -> np.ndarray:
    """
    Create |000...0>.
    """
    state = np.zeros(2 ** n_total, dtype=complex)
    state[0] = 1.0
    return state


def make_ghz_state(n_total: int) -> np.ndarray:
    """
    Create GHZ state: (|000...0> + |111...1>)/sqrt(2).
    """
    state = np.zeros(2 ** n_total, dtype=complex)
    state[0] = 1.0 / np.sqrt(2.0)
    state[-1] = 1.0 / np.sqrt(2.0)
    return state


def main() -> None:
    """
    Compute entanglement entropy for product and GHZ states.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_entanglement_entropy_scaffold.csv"

    rows = []

    for n_total in [4, 6, 8]:
        states = {
            "product_state": make_product_state(n_total),
            "ghz_state": make_ghz_state(n_total),
        }

        for state_name, state in states.items():
            for n_left in range(1, n_total):
                rows.append(
                    {
                        "state_name": state_name,
                        "n_total": n_total,
                        "n_left": n_left,
                        "n_right": n_total - n_left,
                        "entanglement_entropy_nats": entropy_from_state(
                            state=state,
                            n_left=n_left,
                            n_total=n_total,
                        ),
                    }
                )

    output = pd.DataFrame(rows)
    output.to_csv(output_path, index=False)

    print("Entanglement entropy scaffold:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
