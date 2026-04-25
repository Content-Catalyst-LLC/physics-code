"""
Density Matrix Dephasing Channel

This workflow starts with the pure qubit state:

    |+> = (|0> + |1>) / sqrt(2)

and models pure dephasing in the computational basis:

    rho_01(t) = rho_01(0) exp(-t / T2)

The workflow computes:
    - density matrix elements
    - coherence magnitude
    - purity Tr(rho^2)
    - von Neumann entropy in bits
"""

from pathlib import Path

import numpy as np
import pandas as pd


T2_SECONDS = 5.0e-6


def von_neumann_entropy_bits(rho: np.ndarray) -> float:
    """
    Compute von Neumann entropy S(rho) = -Tr(rho log2 rho).
    """
    eigenvalues = np.linalg.eigvalsh(rho)
    eigenvalues = np.clip(eigenvalues.real, 0.0, 1.0)

    nonzero = eigenvalues[eigenvalues > 0.0]
    return float(-np.sum(nonzero * np.log2(nonzero)))


def dephased_density_matrix(time_s: float, t2_seconds: float = T2_SECONDS) -> np.ndarray:
    """
    Return density matrix for a dephased |+> state at time t.
    """
    coherence_factor = np.exp(-time_s / t2_seconds)

    return np.array(
        [
            [0.5, 0.5 * coherence_factor],
            [0.5 * coherence_factor, 0.5],
        ],
        dtype=np.complex128,
    )


def main() -> None:
    """
    Simulate dephasing and save diagnostic values.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_dephasing_channel_diagnostics.csv"

    time_values_s = np.linspace(0.0, 25.0e-6, 101)

    rows = []

    for time_s in time_values_s:
        rho = dephased_density_matrix(time_s)

        purity = np.trace(rho @ rho).real
        coherence_magnitude = abs(rho[0, 1])
        entropy_bits = von_neumann_entropy_bits(rho)

        rows.append(
            {
                "time_s": time_s,
                "time_microseconds": time_s * 1.0e6,
                "rho_00": rho[0, 0].real,
                "rho_11": rho[1, 1].real,
                "coherence_abs_rho_01": coherence_magnitude,
                "purity_tr_rho_squared": purity,
                "von_neumann_entropy_bits": entropy_bits,
            }
        )

    table = pd.DataFrame(rows)
    table.to_csv(output_path, index=False)

    print("Dephasing channel diagnostics:")
    print(table.iloc[::10, :].round(8).to_string(index=False))
    print(f"\nSaved diagnostics to: {output_path}")


if __name__ == "__main__":
    main()
