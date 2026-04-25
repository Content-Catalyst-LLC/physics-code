"""
Two-Band Chern Model

Hamiltonian:

    H(kx, ky) =
        sin(kx) sigma_x
      + sin(ky) sigma_y
      + (m + cos(kx) + cos(ky)) sigma_z

The lower-band Chern number is estimated using:

    C = (1 / 4pi) integral d_hat · (partial_kx d_hat x partial_ky d_hat) d^2k

This is a transparent teaching scaffold.
"""

from pathlib import Path

import numpy as np
import pandas as pd


def d_vector(kx: np.ndarray, ky: np.ndarray, mass: float) -> np.ndarray:
    """
    Return d-vector for the two-band Chern model.
    """
    return np.stack(
        [
            np.sin(kx),
            np.sin(ky),
            mass + np.cos(kx) + np.cos(ky),
        ],
        axis=-1,
    )


def normalize_vectors(vectors: np.ndarray) -> np.ndarray:
    """
    Normalize vector field along the final axis.
    """
    norms = np.linalg.norm(vectors, axis=-1, keepdims=True)

    if np.any(norms == 0.0):
        raise ValueError("Gap closing encountered: d-vector norm is zero.")

    return vectors / norms


def estimate_chern_number(mass: float, n_grid: int) -> dict:
    """
    Estimate Chern number using finite differences on a periodic grid.
    """
    k_values = np.linspace(-np.pi, np.pi, n_grid, endpoint=False)
    delta_k = 2.0 * np.pi / n_grid

    kx, ky = np.meshgrid(k_values, k_values, indexing="ij")

    d_raw = d_vector(kx, ky, mass)
    d_hat = normalize_vectors(d_raw)

    partial_kx = (np.roll(d_hat, -1, axis=0) - np.roll(d_hat, 1, axis=0)) / (2.0 * delta_k)
    partial_ky = (np.roll(d_hat, -1, axis=1) - np.roll(d_hat, 1, axis=1)) / (2.0 * delta_k)

    berry_density = np.sum(d_hat * np.cross(partial_kx, partial_ky), axis=-1)
    chern_raw = np.sum(berry_density) * delta_k * delta_k / (4.0 * np.pi)

    return {
        "mass": mass,
        "n_grid": n_grid,
        "chern_raw": chern_raw,
        "chern_rounded": int(np.round(chern_raw)),
        "minimum_gap_proxy": float(np.min(np.linalg.norm(d_raw, axis=-1))),
    }


def main() -> None:
    """
    Run all configured two-band Chern model cases.
    """
    article_dir = Path(__file__).resolve().parents[1]
    cases = pd.read_csv(article_dir / "data" / "chern_model_cases.csv")

    rows = []

    for _, case in cases.iterrows():
        result = estimate_chern_number(
            mass=float(case["mass"]),
            n_grid=int(case["n_grid"]),
        )

        result.update(
            {
                "case_id": case["case_id"],
                "notes": case["notes"],
            }
        )

        rows.append(result)

    output = pd.DataFrame(rows)
    output.to_csv(article_dir / "data" / "computed_two_band_chern_model.csv", index=False)

    print("Two-band Chern model results:")
    print(output.round(8).to_string(index=False))


if __name__ == "__main__":
    main()
