"""
Semi-Empirical Mass Formula Scaffold

This workflow computes a simplified semi-empirical mass-formula estimate:

    B(A,Z) = a_v A
           - a_s A^(2/3)
           - a_c Z(Z-1)/A^(1/3)
           - a_a(A-2Z)^2/A
           + delta(A,Z)

The result is useful for broad trend intuition, not precision nuclear masses.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def pairing_term(a: int, z: int, pairing_coefficient: float = 12.0) -> float:
    """
    Compute a simplified pairing term.

    Parameters
    ----------
    a:
        Mass number.
    z:
        Proton number.
    pairing_coefficient:
        Pairing coefficient in MeV.

    Returns
    -------
    float
        Pairing contribution in MeV.
    """
    n = a - z

    if a % 2 == 1:
        return 0.0

    if z % 2 == 0 and n % 2 == 0:
        return pairing_coefficient / np.sqrt(a)

    return -pairing_coefficient / np.sqrt(a)


def binding_energy_semf(a: int, z: int) -> float:
    """
    Estimate binding energy using a simplified semi-empirical mass formula.

    Parameters
    ----------
    a:
        Mass number.
    z:
        Proton number.

    Returns
    -------
    float
        Estimated binding energy in MeV.
    """
    a_v = 15.75
    a_s = 17.80
    a_c = 0.711
    a_a = 23.70

    volume = a_v * a
    surface = a_s * a ** (2.0 / 3.0)
    coulomb = a_c * z * (z - 1) / a ** (1.0 / 3.0)
    asymmetry = a_a * (a - 2 * z) ** 2 / a
    pairing = pairing_term(a, z)

    return volume - surface - coulomb - asymmetry + pairing


def main() -> None:
    """
    Apply the SEMF scaffold to sample isotopes.
    """
    article_dir = Path(__file__).resolve().parents[1]
    isotope_input_path = article_dir / "data" / "isotope_sample.csv"
    output_path = article_dir / "data" / "computed_semf_binding_energy.csv"

    isotopes = pd.read_csv(isotope_input_path)

    finite_isotopes = isotopes.loc[isotopes["A"] > 1].copy()

    finite_isotopes["semf_binding_energy_mev"] = [
        binding_energy_semf(int(row.A), int(row.Z))
        for row in finite_isotopes.itertuples(index=False)
    ]

    finite_isotopes["semf_binding_energy_per_nucleon_mev"] = (
        finite_isotopes["semf_binding_energy_mev"] / finite_isotopes["A"]
    )

    finite_isotopes.to_csv(output_path, index=False)

    print("Semi-empirical mass-formula scaffold:")
    print(
        finite_isotopes[
            [
                "nuclide",
                "Z",
                "N",
                "A",
                "semf_binding_energy_mev",
                "semf_binding_energy_per_nucleon_mev",
            ]
        ].round(6).to_string(index=False)
    )

    print(f"\nSaved SEMF table to: {output_path}")


if __name__ == "__main__":
    main()
