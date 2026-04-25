"""
Berry Curvature Grid for Two-Band Chern Model

Stores the local Berry-density-like integrand:

    d_hat · (partial_kx d_hat x partial_ky d_hat)

for selected mass values.
"""

from pathlib import Path

import numpy as np
import pandas as pd

from two_band_chern_model import d_vector, normalize_vectors


def curvature_grid(mass: float, n_grid: int = 101) -> pd.DataFrame:
    """
    Generate Berry-density grid for one mass value.
    """
    k_values = np.linspace(-np.pi, np.pi, n_grid, endpoint=False)
    delta_k = 2.0 * np.pi / n_grid

    kx, ky = np.meshgrid(k_values, k_values, indexing="ij")
    d_hat = normalize_vectors(d_vector(kx, ky, mass))

    partial_kx = (np.roll(d_hat, -1, axis=0) - np.roll(d_hat, 1, axis=0)) / (2.0 * delta_k)
    partial_ky = (np.roll(d_hat, -1, axis=1) - np.roll(d_hat, 1, axis=1)) / (2.0 * delta_k)

    berry_density = np.sum(d_hat * np.cross(partial_kx, partial_ky), axis=-1)

    return pd.DataFrame(
        {
            "mass": mass,
            "kx": kx.ravel(),
            "ky": ky.ravel(),
            "berry_density": berry_density.ravel(),
        }
    )


def main() -> None:
    """
    Generate Berry-density grids for representative masses.
    """
    article_dir = Path(__file__).resolve().parents[1]

    output = pd.concat(
        [
            curvature_grid(mass=-1.0),
            curvature_grid(mass=1.0),
        ],
        ignore_index=True,
    )

    output.to_csv(article_dir / "data" / "computed_berry_curvature_grid.csv", index=False)

    print("Berry curvature grid sample:")
    print(output.groupby("mass").head(5).round(8).to_string(index=False))


if __name__ == "__main__":
    main()
