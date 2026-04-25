"""
Exact Diagonalization of a Transverse-Field Ising Chain

Hamiltonian:

    H = -J sum_i sigma_z(i) sigma_z(i+1) - h sum_i sigma_x(i)

The workflow uses periodic boundary conditions and dense matrices.
It is intended for teaching-scale systems only.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def spin_z_value(state: int, site: int) -> int:
    """
    Return sigma_z eigenvalue (+1 or -1) for a site.
    """
    bit = (state >> site) & 1
    return 1 if bit == 1 else -1


def flip_spin(state: int, site: int) -> int:
    """
    Flip a spin in the computational basis.
    """
    return state ^ (1 << site)


def build_tfim_hamiltonian(
    n_sites: int,
    coupling_j: float,
    transverse_field_h: float,
) -> np.ndarray:
    """
    Build dense transverse-field Ising Hamiltonian.
    """
    dimension = 2 ** n_sites
    hamiltonian = np.zeros((dimension, dimension), dtype=float)

    for state in range(dimension):
        interaction_energy = 0.0

        for site in range(n_sites):
            next_site = (site + 1) % n_sites
            interaction_energy += (
                -coupling_j
                * spin_z_value(state, site)
                * spin_z_value(state, next_site)
            )

        hamiltonian[state, state] += interaction_energy

        for site in range(n_sites):
            flipped_state = flip_spin(state, site)
            hamiltonian[flipped_state, state] += -transverse_field_h

    return hamiltonian


def run_case(case: pd.Series, n_eigenvalues: int = 8) -> pd.DataFrame:
    """
    Diagonalize one finite spin chain and return low-energy eigenvalues.
    """
    n_sites = int(case["n_sites"])

    hamiltonian = build_tfim_hamiltonian(
        n_sites=n_sites,
        coupling_j=float(case["coupling_j"]),
        transverse_field_h=float(case["transverse_field_h"]),
    )

    eigenvalues = np.sort(np.linalg.eigvalsh(hamiltonian))

    rows = []

    for index, energy in enumerate(eigenvalues[:n_eigenvalues]):
        rows.append(
            {
                "case_id": case["case_id"],
                "n_sites": n_sites,
                "hilbert_dimension": 2 ** n_sites,
                "coupling_j": float(case["coupling_j"]),
                "transverse_field_h": float(case["transverse_field_h"]),
                "eigenvalue_index": index,
                "energy": energy,
                "energy_per_site": energy / n_sites,
                "gap_from_ground": energy - eigenvalues[0],
                "boundary_condition": case["boundary_condition"],
                "notes": case["notes"],
            }
        )

    return pd.DataFrame(rows)


def main() -> None:
    """
    Run exact diagonalization for configured spin-chain cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "spin_chain_cases.csv"
    output_path = article_dir / "data" / "computed_spin_chain_spectra.csv"

    cases = pd.read_csv(input_path)
    output = pd.concat([run_case(case) for _, case in cases.iterrows()], ignore_index=True)

    output.to_csv(output_path, index=False)

    print("Spin-chain spectra:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
