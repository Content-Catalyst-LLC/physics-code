"""
Hydrogen Energy Levels and a Schematic Diatomic Potential

This workflow demonstrates two introductory ideas in atomic and molecular
structure:

1. Hydrogen-like Bohr energy levels:
       E_n = -13.6 / n^2  eV

2. A schematic Lennard-Jones-style diatomic potential:
       U(r) = 4*epsilon*((sigma/r)^12 - (sigma/r)^6)

The potential is a teaching scaffold. It is not a quantum-chemical
calculation for a specific molecule.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def hydrogen_energy_levels(n_max: int = 8) -> pd.DataFrame:
    """
    Compute Bohr-like hydrogen energy levels.

    Parameters
    ----------
    n_max:
        Maximum principal quantum number.

    Returns
    -------
    pandas.DataFrame
        Table with n and energy in electron volts.
    """
    n = np.arange(1, n_max + 1)
    energy_ev = -13.6 / n**2

    return pd.DataFrame(
        {
            "n": n,
            "energy_ev": energy_ev,
        }
    )


def transition_energy(initial_n: int, final_n: int) -> float:
    """
    Compute the photon energy for a transition between Bohr-like levels.

    Parameters
    ----------
    initial_n:
        Initial principal quantum number.
    final_n:
        Final principal quantum number.

    Returns
    -------
    float
        Transition energy in electron volts.
    """
    initial_energy = -13.6 / initial_n**2
    final_energy = -13.6 / final_n**2

    return abs(final_energy - initial_energy)


def diatomic_potential(
    r: np.ndarray,
    epsilon: float = 1.0,
    sigma: float = 1.0
) -> np.ndarray:
    """
    Compute a schematic Lennard-Jones-style diatomic potential.

    Parameters
    ----------
    r:
        Internuclear separation in arbitrary units.
    epsilon:
        Well-depth scale in arbitrary energy units.
    sigma:
        Length scale in arbitrary distance units.

    Returns
    -------
    np.ndarray
        Potential energy in arbitrary units.
    """
    return 4.0 * epsilon * ((sigma / r) ** 12 - (sigma / r) ** 6)


def main() -> None:
    """
    Generate output tables for atomic levels, transitions, and a potential curve.
    """
    article_dir = Path(__file__).resolve().parents[1]

    levels_output = article_dir / "data" / "computed_hydrogen_energy_levels.csv"
    transitions_output = article_dir / "data" / "computed_hydrogen_transitions.csv"
    potential_output = article_dir / "data" / "computed_diatomic_potential.csv"
    minimum_output = article_dir / "data" / "computed_diatomic_potential_minimum.csv"

    levels = hydrogen_energy_levels(n_max=8)

    transitions = pd.DataFrame(
        {
            "transition": ["3_to_2", "4_to_2", "5_to_2", "6_to_2"],
            "initial_n": [3, 4, 5, 6],
            "final_n": [2, 2, 2, 2],
        }
    )

    transitions["energy_ev"] = [
        transition_energy(initial_n, final_n)
        for initial_n, final_n in zip(transitions["initial_n"], transitions["final_n"])
    ]

    r = np.linspace(0.75, 3.0, 1000)
    potential = diatomic_potential(r)

    potential_table = pd.DataFrame(
        {
            "r": r,
            "potential": potential,
        }
    )

    minimum_row = potential_table.loc[[potential_table["potential"].idxmin()]]

    levels.to_csv(levels_output, index=False)
    transitions.to_csv(transitions_output, index=False)
    potential_table.to_csv(potential_output, index=False)
    minimum_row.to_csv(minimum_output, index=False)

    print("Hydrogen-like energy levels:")
    print(levels.round(6).to_string(index=False))

    print("\nSelected transitions:")
    print(transitions.round(6).to_string(index=False))

    print("\nApproximate minimum of schematic diatomic potential:")
    print(minimum_row.round(6).to_string(index=False))

    print(f"\nSaved levels to: {levels_output}")
    print(f"Saved transitions to: {transitions_output}")
    print(f"Saved potential curve to: {potential_output}")
    print(f"Saved minimum to: {minimum_output}")


if __name__ == "__main__":
    main()
