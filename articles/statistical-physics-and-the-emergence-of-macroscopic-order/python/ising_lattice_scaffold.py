"""
Ising-Style Lattice Scaffold

This workflow implements a compact 2D Ising-style Monte Carlo scaffold
using the Metropolis rule.

It is intended as a teaching scaffold for order parameters and collective
behavior, not as a production finite-size-scaling research code.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def total_energy(spins: np.ndarray, coupling_j: float = 1.0) -> float:
    """
    Compute nearest-neighbor Ising energy with periodic boundaries.
    """
    right_neighbors = np.roll(spins, shift=-1, axis=1)
    down_neighbors = np.roll(spins, shift=-1, axis=0)

    return float(-coupling_j * np.sum(spins * (right_neighbors + down_neighbors)))


def metropolis_sweep(
    spins: np.ndarray,
    beta: float,
    coupling_j: float,
    rng: np.random.Generator,
) -> None:
    """
    Perform one Metropolis sweep over randomly selected lattice sites.
    """
    n_rows, n_cols = spins.shape

    for _ in range(n_rows * n_cols):
        i = rng.integers(0, n_rows)
        j = rng.integers(0, n_cols)

        spin = spins[i, j]
        neighbor_sum = (
            spins[(i + 1) % n_rows, j]
            + spins[(i - 1) % n_rows, j]
            + spins[i, (j + 1) % n_cols]
            + spins[i, (j - 1) % n_cols]
        )

        delta_energy = 2.0 * coupling_j * spin * neighbor_sum

        if delta_energy <= 0.0 or rng.random() < np.exp(-beta * delta_energy):
            spins[i, j] = -spin


def main() -> None:
    """
    Run a small Ising-style scaffold and summarize magnetization.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_ising_scaffold_summary.csv"

    rng = np.random.default_rng(42)
    lattice_size = 32
    coupling_j = 1.0

    beta_values = [0.2, 0.4, 0.6, 0.8]
    rows = []

    for beta in beta_values:
        spins = rng.choice([-1, 1], size=(lattice_size, lattice_size))

        for _ in range(500):
            metropolis_sweep(spins, beta=beta, coupling_j=coupling_j, rng=rng)

        magnetization = float(np.mean(spins))
        energy_per_spin = total_energy(spins, coupling_j=coupling_j) / spins.size

        rows.append(
            {
                "lattice_size": lattice_size,
                "beta": beta,
                "temperature_inverse_units": beta,
                "magnetization": magnetization,
                "absolute_magnetization": abs(magnetization),
                "energy_per_spin": energy_per_spin,
            }
        )

    summary = pd.DataFrame(rows)
    summary.to_csv(output_path, index=False)

    print("Ising-style lattice scaffold summary:")
    print(summary.to_string(index=False))
    print(f"\nSaved summary to: {output_path}")


if __name__ == "__main__":
    main()
