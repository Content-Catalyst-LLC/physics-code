"""
Lattice Scalar Field Scaffold

This workflow evaluates a one-dimensional Euclidean lattice scalar action:

    S_E = sum_x [
        1/2 ((phi[x+1] - phi[x])/a)^2
        + 1/2 m^2 phi[x]^2
        + lambda/4! phi[x]^4
    ] * a

using deterministic sinusoidal field configurations.
"""

from pathlib import Path

import math
import numpy as np
import pandas as pd


def lattice_action(phi: np.ndarray, lattice_spacing: float, mass_squared: float, lambda_coupling: float) -> dict:
    """
    Compute kinetic, mass, interaction, and total lattice action.
    """
    shifted = np.roll(phi, -1)

    gradient = (shifted - phi) / lattice_spacing

    kinetic = float(np.sum(0.5 * gradient**2 * lattice_spacing))
    mass_term = float(np.sum(0.5 * mass_squared * phi**2 * lattice_spacing))
    interaction = float(np.sum(lambda_coupling / math.factorial(4) * phi**4 * lattice_spacing))

    return {
        "kinetic_action": kinetic,
        "mass_action": mass_term,
        "interaction_action": interaction,
        "total_action": kinetic + mass_term + interaction,
    }


def run_case(case: pd.Series) -> dict:
    """
    Evaluate one lattice scalar field case.
    """
    n_sites = int(case["n_sites"])
    lattice_spacing = float(case["lattice_spacing"])
    amplitude = float(case["field_amplitude"])

    positions = np.arange(n_sites) * lattice_spacing
    total_length = n_sites * lattice_spacing

    phi = amplitude * np.sin(2.0 * np.pi * positions / total_length)

    result = lattice_action(
        phi=phi,
        lattice_spacing=lattice_spacing,
        mass_squared=float(case["mass_squared"]),
        lambda_coupling=float(case["lambda_coupling"]),
    )

    result.update(
        {
            "case_id": case["case_id"],
            "n_sites": n_sites,
            "lattice_spacing": lattice_spacing,
            "mass_squared": float(case["mass_squared"]),
            "lambda_coupling": float(case["lambda_coupling"]),
            "field_amplitude": amplitude,
            "mean_phi_squared": float(np.mean(phi**2)),
            "notes": case["notes"],
        }
    )

    return result


def main() -> None:
    """
    Evaluate lattice scalar field action scaffolds.
    """
    article_dir = Path(__file__).resolve().parents[1]
    input_path = article_dir / "data" / "lattice_scalar_cases.csv"
    output_path = article_dir / "data" / "computed_lattice_scalar_field_scaffold.csv"

    cases = pd.read_csv(input_path)
    output = pd.DataFrame([run_case(case) for _, case in cases.iterrows()])

    output.to_csv(output_path, index=False)

    print("Lattice scalar field scaffold:")
    print(output.round(10).to_string(index=False))


if __name__ == "__main__":
    main()
