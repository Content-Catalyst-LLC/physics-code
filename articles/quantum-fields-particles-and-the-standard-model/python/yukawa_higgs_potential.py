"""
Yukawa Couplings and a Schematic Higgs Potential

This workflow demonstrates two introductory Standard Model ideas:

1. Fermion mass and Yukawa coupling:
       y_f = sqrt(2) * m_f / v

2. Schematic symmetry-breaking scalar potential:
       V(phi) = mu2 * phi^2 + lambda * phi^4

The potential here is a one-dimensional educational scaffold.
It is not the full Standard Model Higgs doublet potential.
"""

from pathlib import Path

import numpy as np
import pandas as pd


HIGGS_VEV_GEV = 246.0


def yukawa_coupling(mass_gev: np.ndarray, higgs_vev_gev: float = HIGGS_VEV_GEV) -> np.ndarray:
    """
    Compute schematic Yukawa couplings from fermion masses.

    Parameters
    ----------
    mass_gev:
        Fermion masses in GeV.
    higgs_vev_gev:
        Higgs vacuum expectation value in GeV.

    Returns
    -------
    np.ndarray
        Dimensionless Yukawa couplings.
    """
    return np.sqrt(2.0) * mass_gev / higgs_vev_gev


def higgs_like_potential(phi: np.ndarray, mu2: float = -1.0, lam: float = 0.5) -> np.ndarray:
    """
    Compute a schematic one-dimensional symmetry-breaking potential.

    Parameters
    ----------
    phi:
        Field-like values.
    mu2:
        Quadratic coefficient.
    lam:
        Quartic coefficient. Positive lambda stabilizes the potential.

    Returns
    -------
    np.ndarray
        Potential values.
    """
    if lam <= 0:
        raise ValueError("The quartic coefficient should be positive for stability.")

    return mu2 * phi**2 + lam * phi**4


def main() -> None:
    """
    Generate Yukawa and Higgs-potential output tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    fermion_input = article_dir / "data" / "fermion_mass_sample.csv"
    yukawa_output = article_dir / "data" / "computed_yukawa_couplings.csv"
    potential_output = article_dir / "data" / "computed_higgs_like_potential.csv"
    minima_output = article_dir / "data" / "computed_higgs_like_potential_minima.csv"

    fermions = pd.read_csv(fermion_input)
    fermions["yukawa_coupling"] = yukawa_coupling(
        fermions["mass_gev"].to_numpy(dtype=float)
    )
    fermions["log10_yukawa"] = np.log10(fermions["yukawa_coupling"])

    phi = np.linspace(-3.0, 3.0, 2001)
    potential = higgs_like_potential(phi)

    potential_table = pd.DataFrame(
        {
            "phi": phi,
            "potential": potential,
        }
    )

    minimum_value = potential_table["potential"].min()
    minima = potential_table.loc[
        (potential_table["potential"] - minimum_value).abs() < 1e-4
    ]

    fermions.to_csv(yukawa_output, index=False)
    potential_table.to_csv(potential_output, index=False)
    minima.to_csv(minima_output, index=False)

    print("Illustrative Yukawa couplings:")
    print(fermions.round(8).to_string(index=False))

    print("\nApproximate minima of schematic Higgs-like potential:")
    print(minima.head(20).round(6).to_string(index=False))

    print(f"\nSaved Yukawa table to: {yukawa_output}")
    print(f"Saved potential table to: {potential_output}")
    print(f"Saved minima table to: {minima_output}")


if __name__ == "__main__":
    main()
