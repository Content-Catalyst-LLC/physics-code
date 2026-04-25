"""
Quantum State Interpretations

This workflow demonstrates a core philosophy-of-physics point:
the same mathematical formalism can support different ontological
interpretations.

The example uses a normalized two-state vector:

    psi = [1/sqrt(2), 1/sqrt(2)]

Born-rule probabilities:

    P_i = |psi_i|^2

The probabilities are fixed by the formalism, but the interpretation
of the state vector remains philosophically contested.
"""

import numpy as np
import pandas as pd


def born_probabilities(state_vector: np.ndarray) -> np.ndarray:
    """
    Compute Born-rule probabilities from a normalized state vector.

    Parameters
    ----------
    state_vector:
        Complex-valued quantum state vector.

    Returns
    -------
    np.ndarray
        Probability for each basis outcome.
    """
    return np.abs(state_vector) ** 2


def is_normalized(state_vector: np.ndarray, tolerance: float = 1e-10) -> bool:
    """
    Check whether the state vector has unit norm.

    Parameters
    ----------
    state_vector:
        Complex-valued quantum state vector.
    tolerance:
        Numerical tolerance for normalization check.

    Returns
    -------
    bool
        True if the norm is approximately one.
    """
    norm_squared = np.sum(np.abs(state_vector) ** 2)
    return bool(np.isclose(norm_squared, 1.0, atol=tolerance))


def main() -> None:
    """
    Print probabilities and compare interpretive readings.
    """
    psi = np.array([1 / np.sqrt(2), 1 / np.sqrt(2)], dtype=complex)

    interpretations = pd.DataFrame(
        {
            "interpretation": [
                "ontic",
                "epistemic",
                "relational",
                "operational",
            ],
            "reading": [
                "The state vector represents a physically real feature of the system.",
                "The state vector represents knowledge, information, or credence.",
                "The state vector is assigned relative to another system or observer.",
                "The state vector is a tool for predicting measurement outcomes.",
            ],
        }
    )

    probabilities = born_probabilities(psi)

    print("State vector:")
    print(psi)

    print("\nIs normalized?")
    print(is_normalized(psi))

    print("\nBorn-rule probabilities:")
    print(probabilities)

    print("\nInterpretive readings:")
    print(interpretations.to_string(index=False))


if __name__ == "__main__":
    main()
