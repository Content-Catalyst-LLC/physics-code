"""
Band and Phonon Dispersion

This workflow demonstrates three introductory condensed-matter models:

1. Free-electron-like dispersion:
       E(k) = k^2

2. One-dimensional tight-binding band:
       E(k) = E0 - 2*t*cos(k*a)

3. One-dimensional phonon-style dispersion:
       omega(k) = 2*sqrt(K/M)*abs(sin(k*a/2))

The values are expressed in arbitrary units for conceptual clarity.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def free_electron_energy(k: np.ndarray) -> np.ndarray:
    """
    Compute a free-electron-like dispersion in arbitrary units.
    """
    return k**2


def tight_binding_energy(k: np.ndarray, hopping: float = 1.0, lattice_spacing: float = 1.0) -> np.ndarray:
    """
    Compute a one-dimensional tight-binding dispersion.
    """
    return -2.0 * hopping * np.cos(k * lattice_spacing)


def phonon_frequency(
    k: np.ndarray,
    spring_constant: float = 1.0,
    mass: float = 1.0,
    lattice_spacing: float = 1.0
) -> np.ndarray:
    """
    Compute a simple one-dimensional phonon-style dispersion.
    """
    return 2.0 * np.sqrt(spring_constant / mass) * np.abs(
        np.sin(k * lattice_spacing / 2.0)
    )


def main() -> None:
    """
    Generate and save dispersion tables.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_band_phonon_dispersion.csv"

    k = np.linspace(-np.pi, np.pi, 801)

    dispersion_table = pd.DataFrame(
        {
            "k": k,
            "free_electron_energy": free_electron_energy(k),
            "tight_binding_energy": tight_binding_energy(k),
            "phonon_frequency": phonon_frequency(k),
        }
    )

    dispersion_table.to_csv(output_path, index=False)

    print("Condensed-matter dispersion sample:")
    print(dispersion_table.head(12).round(6).to_string(index=False))
    print(f"\nSaved dispersion table to: {output_path}")


if __name__ == "__main__":
    main()
