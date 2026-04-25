"""
Energy Landscape and Accessible Motion

This workflow evaluates a one-dimensional potential-energy landscape:

    U(x) = 1/2 k x^2 + a x^4

and identifies where motion is accessible for a specified total energy:

    E >= U(x)

Turning points occur near E = U(x).
"""

from pathlib import Path

import numpy as np
import pandas as pd


def potential_energy(x_m: np.ndarray, k_n_per_m: float, quartic_j_per_m4: float) -> np.ndarray:
    """
    Compute a simple anharmonic potential-energy landscape.
    """
    return 0.5 * k_n_per_m * x_m**2 + quartic_j_per_m4 * x_m**4


def main() -> None:
    """
    Generate accessible-motion metadata for a one-dimensional landscape.
    """
    article_dir = Path(__file__).resolve().parents[1]
    output_path = article_dir / "data" / "computed_energy_landscape_accessible_motion.csv"

    x_m = np.linspace(-0.5, 0.5, 2000)
    total_energy_j = 0.40

    landscape = pd.DataFrame(
        {
            "position_m": x_m,
            "potential_energy_j": potential_energy(
                x_m,
                k_n_per_m=5.0,
                quartic_j_per_m4=20.0,
            ),
        }
    )

    landscape["total_energy_j"] = total_energy_j
    landscape["kinetic_energy_allowed_j"] = (
        landscape["total_energy_j"] - landscape["potential_energy_j"]
    )
    landscape["is_accessible"] = landscape["kinetic_energy_allowed_j"] >= 0.0

    accessible = landscape[landscape["is_accessible"]]

    summary = pd.DataFrame(
        [
            {
                "total_energy_j": total_energy_j,
                "min_accessible_position_m": accessible["position_m"].min(),
                "max_accessible_position_m": accessible["position_m"].max(),
                "n_accessible_grid_points": len(accessible),
            }
        ]
    )

    landscape.to_csv(output_path, index=False)

    print("Energy landscape summary:")
    print(summary.round(8).to_string(index=False))
    print(f"\nSaved landscape table to: {output_path}")


if __name__ == "__main__":
    main()
