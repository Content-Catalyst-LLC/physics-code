"""
Bell State Entanglement Entropy

This workflow constructs the Bell state:

    |Phi+> = (|00> + |11>) / sqrt(2)

then computes the reduced density matrix of one qubit and its von Neumann entropy.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def von_neumann_entropy_bits(rho: np.ndarray) -> float:
    """
    Compute von Neumann entropy in bits.
    """
    eigenvalues = np.linalg.eigvalsh(rho)
    eigenvalues = np.clip(eigenvalues.real, 0.0, 1.0)
    nonzero = eigenvalues[eigenvalues > 0.0]
    return float(-np.sum(nonzero * np.log2(nonzero)))


def partial_trace_second_qubit(rho_ab: np.ndarray) -> np.ndarray:
    """
    Trace out the second qubit from a two-qubit density matrix.
    """
    rho_tensor = rho_ab.reshape(2, 2, 2, 2)
    return np.trace(rho_tensor, axis1=1, axis2=3)


def main() -> None:
    """
    Compute Bell-state reduced density matrix and entropy.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_bell_state_entanglement_entropy.csv"

    state = np.array([1.0, 0.0, 0.0, 1.0], dtype=np.complex128) / np.sqrt(2.0)
    rho_ab = np.outer(state, np.conjugate(state))
    rho_a = partial_trace_second_qubit(rho_ab)

    table = pd.DataFrame(
        [
            {
                "rho_a_00": rho_a[0, 0].real,
                "rho_a_01_real": rho_a[0, 1].real,
                "rho_a_01_imag": rho_a[0, 1].imag,
                "rho_a_10_real": rho_a[1, 0].real,
                "rho_a_10_imag": rho_a[1, 0].imag,
                "rho_a_11": rho_a[1, 1].real,
                "reduced_state_purity": np.trace(rho_a @ rho_a).real,
                "entanglement_entropy_bits": von_neumann_entropy_bits(rho_a),
            }
        ]
    )

    table.to_csv(output_path, index=False)

    print("Bell-state entanglement entropy:")
    print(table.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
