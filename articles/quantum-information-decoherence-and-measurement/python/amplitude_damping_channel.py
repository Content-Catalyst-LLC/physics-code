"""
Amplitude Damping Channel

This workflow applies a qubit amplitude damping channel with damping
probability gamma.

Kraus operators:

    K0 = [[1, 0], [0, sqrt(1-gamma)]]
    K1 = [[0, sqrt(gamma)], [0, 0]]
"""

from pathlib import Path

import numpy as np
import pandas as pd


def amplitude_damping(rho: np.ndarray, gamma: float) -> np.ndarray:
    """
    Apply amplitude damping channel to a qubit density matrix.
    """
    k0 = np.array(
        [
            [1.0, 0.0],
            [0.0, np.sqrt(1.0 - gamma)],
        ],
        dtype=np.complex128,
    )

    k1 = np.array(
        [
            [0.0, np.sqrt(gamma)],
            [0.0, 0.0],
        ],
        dtype=np.complex128,
    )

    return k0 @ rho @ k0.conj().T + k1 @ rho @ k1.conj().T


def main() -> None:
    """
    Apply amplitude damping to an initial excited state.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_amplitude_damping_channel.csv"

    excited_state = np.array([0.0, 1.0], dtype=np.complex128)
    rho_initial = np.outer(excited_state, excited_state.conj())

    gamma_values = np.linspace(0.0, 1.0, 101)

    rows = []

    for gamma in gamma_values:
        rho = amplitude_damping(rho_initial, float(gamma))
        rows.append(
            {
                "gamma": gamma,
                "rho_00": rho[0, 0].real,
                "rho_11": rho[1, 1].real,
                "coherence_abs_rho_01": abs(rho[0, 1]),
                "purity": np.trace(rho @ rho).real,
            }
        )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Amplitude damping channel sample:")
    print(table.iloc[::10, :].round(8).to_string(index=False))


if __name__ == "__main__":
    main()
