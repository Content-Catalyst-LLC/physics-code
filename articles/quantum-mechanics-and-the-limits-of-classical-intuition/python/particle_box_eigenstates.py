"""
Particle in a Box: Eigenstates, Energies, and Expectation Values

This workflow computes analytic particle-in-a-box eigenstates and energies:

    psi_n(x) = sqrt(2/L) * sin(n*pi*x/L)

    E_n = n^2*pi^2*hbar^2 / (2*m*L^2)

It also estimates expectation values and uncertainties numerically.
"""

from pathlib import Path

import numpy as np
import pandas as pd


HBAR_J_S = 1.054_571_817e-34
ELECTRON_MASS_KG = 9.109_383_7015e-31
JOULE_PER_EV = 1.602_176_634e-19


def particle_in_box_psi(n: int, x_m: np.ndarray, box_length_m: float) -> np.ndarray:
    """
    Compute the normalized particle-in-a-box wavefunction.
    """
    if n <= 0:
        raise ValueError("Quantum number n must be positive.")

    return np.sqrt(2.0 / box_length_m) * np.sin(n * np.pi * x_m / box_length_m)


def particle_in_box_energy_j(
    n: int,
    mass_kg: float,
    box_length_m: float,
    hbar_j_s: float = HBAR_J_S
) -> float:
    """
    Compute the particle-in-a-box energy eigenvalue in joules.
    """
    return (n**2 * np.pi**2 * hbar_j_s**2) / (2.0 * mass_kg * box_length_m**2)


def expectation_x(x_m: np.ndarray, probability_density: np.ndarray) -> float:
    """
    Estimate the expectation value of position.
    """
    return float(np.trapz(x_m * probability_density, x_m))


def uncertainty_x(x_m: np.ndarray, probability_density: np.ndarray) -> float:
    """
    Estimate the position uncertainty.
    """
    mean_x = expectation_x(x_m, probability_density)
    mean_x2 = float(np.trapz((x_m**2) * probability_density, x_m))

    return float(np.sqrt(mean_x2 - mean_x**2))


def main() -> None:
    """
    Compute eigenstate summaries for the first five particle-in-a-box states.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_particle_box_eigenstates.csv"

    box_length_m = 1.0e-9
    x_m = np.linspace(0.0, box_length_m, 2000)

    rows = []

    for n in range(1, 6):
        psi = particle_in_box_psi(n, x_m, box_length_m)
        probability_density = psi**2

        energy_j = particle_in_box_energy_j(
            n=n,
            mass_kg=ELECTRON_MASS_KG,
            box_length_m=box_length_m
        )

        rows.append(
            {
                "n": n,
                "energy_j": energy_j,
                "energy_ev": energy_j / JOULE_PER_EV,
                "normalization_check": float(np.trapz(probability_density, x_m)),
                "expectation_x_m": expectation_x(x_m, probability_density),
                "uncertainty_x_m": uncertainty_x(x_m, probability_density),
            }
        )

    summary = pd.DataFrame(rows)
    summary.to_csv(output_path, index=False)

    print("Particle-in-a-box quantum-state summary:")
    print(summary.to_string(index=False))
    print(f"\nSaved summary to: {output_path}")


if __name__ == "__main__":
    main()
