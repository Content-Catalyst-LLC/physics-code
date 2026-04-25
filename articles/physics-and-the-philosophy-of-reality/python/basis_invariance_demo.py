"""
Basis Invariance Demonstration

This workflow illustrates that a change of basis can alter representation
without changing the norm of a quantum state.

Philosophical point:
Not every mathematical difference corresponds to a physical difference.
This is central to debates about representation, ontology, and invariance.
"""

import numpy as np


def state_norm_squared(state_vector: np.ndarray) -> float:
    """
    Compute the squared norm of a complex state vector.

    Parameters
    ----------
    state_vector:
        Complex-valued state vector.

    Returns
    -------
    float
        Sum of squared amplitudes.
    """
    return float(np.sum(np.abs(state_vector) ** 2))


def hadamard_matrix() -> np.ndarray:
    """
    Return the two-dimensional Hadamard transformation matrix.

    Returns
    -------
    np.ndarray
        2x2 unitary matrix.
    """
    return (1 / np.sqrt(2)) * np.array(
        [
            [1, 1],
            [1, -1],
        ],
        dtype=complex,
    )


def main() -> None:
    """
    Apply a unitary transformation and compare norm preservation.
    """
    psi = np.array([1.0, 0.0], dtype=complex)
    transformation = hadamard_matrix()
    transformed_psi = transformation @ psi

    print("Original state:")
    print(psi)

    print("\nTransformed state:")
    print(transformed_psi)

    print("\nOriginal norm squared:")
    print(state_norm_squared(psi))

    print("\nTransformed norm squared:")
    print(state_norm_squared(transformed_psi))


if __name__ == "__main__":
    main()
